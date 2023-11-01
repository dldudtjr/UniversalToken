// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract Keymng {

    struct VoteAccount{
         string myKey;
         bool chk;
     }

    struct Voting{
         string data;
         uint cnt;
         bool chk;
     }

     struct Voter{
         string userId;
         bool chk;
     }

     struct VoteInfo{
         string data;
         uint256 voteStatus;
         Voter[] voters;
         string[] txId;
     }

     struct VoteInfotest{
         bytes32 key;
         bytes data;
     }



    mapping(string => Voting) public Votings;
    mapping(string => VoteAccount) public VoteAccounts;
    mapping(string => VoteInfo) public VoteInfos;
    mapping(string => VoteInfotest) public voteInfotests;

event AccountManage(address indexed typ, string userId, string data);

    /*
        입력데이터:
                    key =  yM1ly4bM62iduqp1VRd2Dy3agJItV5Essr7jtOcykkavnfMJPTVLQi7OkTfSuqh5
                    data = eiZIyftcHcWubyukYC60+Fjb2BEmHXmHVsjCnom1oAPPMcCwLL67xKOgwRuCPxhdeoX9a9gnp/xd09+9MmV0o870p7k8vpuzF4FwykjaVtQ
        평균 입력 데이터 크기: 171 byte
        설명: 사용자의 투표 키 저장
        호출빈도: 보통
    */




     function setKeyInfo(string memory _key,string memory _data) public {
         VoteAccount memory data = VoteAccounts[_key];
         if(data.chk == true){
            VoteAccounts[_key].chk = false;
         }else{
             VoteAccounts[_key].myKey = _data;
             VoteAccounts[_key].chk = true;

             emit AccountManage(msg.sender,_key,_data);

         }
     }

     function setKeyInfoByte(string memory _key, bytes32 _partition, bytes calldata _data ) public {
         voteInfotests[_key].key = _partition;
         voteInfotests[_key].data = _data;
     }

     function getKeyInfoByte(string memory _key) public view 
         returns (bytes32 _partition){
         return voteInfotests[_key].key;
     }


     /*
        입력데이터:
                key =  yM1ly4bM62iduqp1VRd2Dy3agJItV5Essr7jtOcykkavnfMJPTVLQi7OkTfSuqh5

        평균 입력 데이터 크기: 64 byte
        설명: 사용자의 투표 키 요청
        호출빈도 : 높음

    */
     function getKeyInfo(
          string memory _key
         )  public view
                returns (string memory _data){
         return VoteAccounts[_key].myKey;
     }


     /*
        입력데이터:
                key 	= vtm20210928161239001 ( 투표 키값 )
                status	= 1 (투표의 상태값 )
                data 	= 330369585 (데이터의 해쉬 값 )
        평균 입력 데이터 크기: 64 byte
        설명: 투표 정보 저장
        호출빈도 : 낮음

    */
     function setVoteInfo(string memory _key, uint256  _status,string memory _data) public {
             VoteInfo memory voteinfo = VoteInfos[_key];
             if(voteinfo.voteStatus == 4){

             }else{
                 VoteInfos[_key].data = _data;
                 VoteInfos[_key].voteStatus = _status;
             }
     }


	/*
        입력데이터:
                key 	= vtm20210928161239001 ( 투표 키값 )
        평균 입력 데이터 크기: 20 byte
        설명: 투표의 진행 상태를 가져온다
        호출빈도 : 높음

    */
      function getVoteStatus(
           string memory _key
         )  public view
                returns (uint256 _status){
         return VoteInfos[_key].voteStatus;
        }

     /*
        입력데이터:
                key 	= vtm20210928161239001 ( 투표 키값 )
        평균 입력 데이터 크기: 20 byte
        설명: 진행중인 투표의 해쉬데이터를 가져온다.
        호출빈도 : 높음

    */
     function getVoteInfo(
           string memory _key
         )  public view
                returns (string memory _data){
         return VoteInfos[_key].data;
     }


     /*
        입력데이터:
                key 		= vtm20210928161239001     (투표 생성 )
                voteDtlkey	= vcm202109160000000042    (투표 선택지의 키)
                voteCmptkey	= vtmd2021223508 		   (완료한 투표 목록의 키)
                userId		= usr20200000968           (투표를 진행한 사용자의 키 )
                txId		= 0x74b8d445f62edd3437d730a52b9dc5860d3f9365141f2be773ca84d622502862  ( 투표를 한 트랜잭션 해쉬)
                data		= Pa4HISBKnjDSyFgxtCBZvkqBEMEbhEYAIgbSXCWJEusr20200000968vtm20210916111434001 (암호화한 투표데이터 )
        평균 입력 데이터 크기: 210 byte
        설명: 사용자가 투표를 진행한 내용을 저장한다.
        호출빈도 : 높음

    */
    function setVoting(string memory _key, string memory _voteDtlkey,string memory _voteCmptkey, string memory _userId, string memory _data) public {

            VoteInfo memory voteinfo = VoteInfos[_key];

            if(voteinfo.voteStatus == 4){

             }else{
                uint count  = Votings[_voteDtlkey].cnt + 1;
                Votings[_voteDtlkey].cnt = count;
                Votings[_voteCmptkey].data = _data;
                Votings[_voteCmptkey].chk = true;

                VoteInfos[_key].voters.push(Voter({
                        userId: _userId,
                        chk: true
                 }));
             }
     }


     /*
        입력데이터:
                key 	= vtm20210928161239001
        평균 입력 데이터 크기: 20 byte
        설명: 사용자가 진행한 투표의 암호회된 갑을 가져온다.
        호출빈도 : 높음
    */
     function getVoting(
          string memory _key
         )  public view
                returns (string memory _data){
         return Votings[_key].data;
        }

 }
