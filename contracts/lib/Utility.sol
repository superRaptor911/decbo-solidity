pragma solidity ^0.8.3;

library Utility {
    
    function strcmp(string calldata s1, string calldata s2) public pure returns(bool) {
        bytes memory str1 = bytes(s1);
        bytes memory str2 = bytes(s2);

        if (str1.length != str2.length) {
            return false;
        }

        for(uint i = 0; i < str1.length; i++) {
            if (str1[i] != str2[i]) {
                return false;
            }
        }

        return true;
    }

    // Get sub string match level
    function geStrMatchLevel(
        string calldata str,
        string calldata subStr) 
        public pure returns(uint) {
        uint value = 0;
        bytes memory mainString = bytes(str);
        bytes memory subString = bytes(subStr);

        for(uint i = 0 ; i < mainString.length ; i++) {
            for(uint j = 0; j < subString.length; j++) {
                value = value > j ? value : j;
                if (mainString.length > i+ j && mainString[i + j] != subString[j]) {
                    break;
                }
            }
        }
        return value;
    }

    function quickSort(uint[] memory arr, int left, int right, bool isAscending) internal pure {
        int i = left;
        int j = right;
        if (i == j) return;
        uint pivot = arr[uint(left + (right - left) / 2)];
        while (i <= j) {
            while (arr[uint(i)] < pivot) i++;
            while (pivot < arr[uint(j)]) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j, isAscending);
        if (i < right)
            quickSort(arr, i, right, isAscending);
    }

    function sortUintArr(uint[] memory arr, bool isAscending) public pure {
        quickSort(arr, int(0), int(arr.length - 1), isAscending);
    }

    // function filterUintArr(uint[] calldata arr, uint filterValue) public {
    //     uint[] memory newArr = new uint[](arr);
    //     for(uint i = 0; i < arr.length; i++) {
    //         if (arr[i] != filterValue) {
    //             newArr.push(arr[i]);
    //         }
    //     }
    // }
}
