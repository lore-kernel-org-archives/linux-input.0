Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021137.outbound.protection.outlook.com [40.107.130.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDAB39A7EA;
	Wed,  4 Feb 2026 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770248560; cv=fail; b=JTCXvi4oNC0fO1GK0GmnrMbZRkYl9X0sherU2LYZQd/qx5qe1OnTHIGxh0kK0Nbi+edVCgsv/FcWxiNZLxvMWDnQYLVyLj0LInpxGQ5307EfNQwZxtzbv6pUheX9gRF4EWg/5uFPfClQmJ7rwob4k2L01RjekzHaF9nIVveFq7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770248560; c=relaxed/simple;
	bh=XDlbXjGnwuL237FUmQckjEECA8Og2dNy4xCyetESIUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CYhg2sMuAck5f01LpZPnM0IbVHMBz14xAQc1zJk/tUOu4OQIwbixGqJEGICUpndI17q6Mudjifx9JSsa09B465EbzTs1cOCfQec7wfJ4KAa0sqoOI7+hzm8cFiDonelVASZy3Up02Mu9qwGe+v9OVokfP/vGrUEbzkVstHbcqsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wacom.com; spf=pass smtp.mailfrom=wacom.com; dkim=pass (1024-bit key) header.d=wacom.com header.i=@wacom.com header.b=uG7TKuUD; arc=fail smtp.client-ip=40.107.130.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wacom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wacom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wacom.com header.i=@wacom.com header.b="uG7TKuUD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJIUDndP+WPgfF8pzblf2Lz5v3hAiYy0gyK+8xG8R1OLOwUCzr533aTG3pPYQ7+TVstffENRarUZujSEkWdXZ2Pwatrl8lxbElZ1wtlH2IoDSZ83CE1X8MllbJucY/90SReW2B9kya7xOBWGir6UbZ0QmINigCO4Kv6sDQ2hYtTDiRhJeFo6dWgJSxRH6uzAmOaCqDsJJ3e2BInym5n29wA/QPnLWJyOJ87L8Yz93LHFCSVlyU9b9rXwFLLt7chnofTBH6x7kj2q1TgQxQy8XlFC3MVZ7dbXoijD7fEA+B18TQ7jL4D5Q/wJYi1UOz90eNHe2IVYNCmSR02Fb2NzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDlbXjGnwuL237FUmQckjEECA8Og2dNy4xCyetESIUg=;
 b=Uz8ritYICVP0lPnGUOC7PAH8oMlb1Dsv31XdgLKbHIs1xC92WjW9zMFQBfrcOZ+eX2UyDCSzkKURR0/cV3NqKPnWVVaj+I7vPFoVFCe4Gwj/YUg5KsXGV7I0U1NPEqOQKs3/ZUaQj0eSpqK1vA4IyJe36KiO59OlggQKd8rx7stEcCBR6cTmBGy706L0mIDS08QLlWKX7Jg1jDo2ufMmSkVINGlGe/uDVxdsYiAACQ38wVP3dFc5sX+zHryQMtny6g7KvdD9UYIb8azY+gQTPjvm15gNleXsmdmAovMUw+pp8YUjzayWAUV84YDCdNp9/SPN0MG7uzmR84RkgCNWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wacom.com; dmarc=pass action=none header.from=wacom.com;
 dkim=pass header.d=wacom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wacom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDlbXjGnwuL237FUmQckjEECA8Og2dNy4xCyetESIUg=;
 b=uG7TKuUD8NWqBIX2ImjZTax5Rgc9RBYgBwMeMDDZYYA/lvCtQdtT0Uy0bQXh915xGdOCnyl4/wi1BujqaihGvrYOwRpD9YRy/0/k/sR1/7VbUbiZQXd2W4GjVB0LJBc8dyldzWSe9zfcpfnlv4Kt9lL+8uA8AcPEKXNgbSB0j8c=
Received: from AS8PR07MB8373.eurprd07.prod.outlook.com (2603:10a6:20b:444::19)
 by DB9PR07MB11230.eurprd07.prod.outlook.com (2603:10a6:10:60e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 23:42:34 +0000
Received: from AS8PR07MB8373.eurprd07.prod.outlook.com
 ([fe80::d58:3fb3:437f:933f]) by AS8PR07MB8373.eurprd07.prod.outlook.com
 ([fe80::d58:3fb3:437f:933f%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 23:42:33 +0000
From: "Skomra, Erin" <erin.skomra@wacom.com>
To: Alex Tran <alex.t.tran@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, Shuah Khan <shuah@kernel.org>
CC: "Cheng, Ping" <Ping.Cheng@wacom.com>, "Gerecke, Jason"
	<Jason.Gerecke@wacom.com>, Erin Skomra <skomra@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] selftests: hid: tests: test_wacom_generic: add tests
 for display devices and opaque devices
Thread-Topic: [PATCH v3] selftests: hid: tests: test_wacom_generic: add tests
 for display devices and opaque devices
Thread-Index: AQHckw1v3xWqKja3rUKqgyX6SY0sWrVzOVzA
Date: Wed, 4 Feb 2026 23:42:32 +0000
Message-ID:
 <AS8PR07MB8373592F3C7C20ACE67808EDF598A@AS8PR07MB8373.eurprd07.prod.outlook.com>
References:
 <20260131-wacom_selftests_display_opaque_dev_tests-v3-1-0857d734ba4b@gmail.com>
In-Reply-To:
 <20260131-wacom_selftests_display_opaque_dev_tests-v3-1-0857d734ba4b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a19119ff-427d-44d8-8ea3-7850489cd599_ActionId=3e3dcb03-268d-410c-be70-27fcc7be4008;MSIP_Label_a19119ff-427d-44d8-8ea3-7850489cd599_ContentBits=0;MSIP_Label_a19119ff-427d-44d8-8ea3-7850489cd599_Enabled=true;MSIP_Label_a19119ff-427d-44d8-8ea3-7850489cd599_Method=Standard;MSIP_Label_a19119ff-427d-44d8-8ea3-7850489cd599_Name=defa4170-0d19-0005-0004-bc88714345d2;MSIP_Label_a19119ff-427d-44d8-8ea3-7850489cd599_SetDate=2026-02-04T23:41:07Z;MSIP_Label_a19119ff-427d-44d8-8ea3-7850489cd599_SiteId=9655a91b-107e-4537-834e-d15e84872626;MSIP_Label_a19119ff-427d-44d8-8ea3-7850489cd599_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wacom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB8373:EE_|DB9PR07MB11230:EE_
x-ms-office365-filtering-correlation-id: 1691cff0-cfa6-40d3-ce1d-08de6447115b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7142099003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MW8weXNqZUIxUkF2RG5mNGVYMXEwU0lPNFV5YW9UOEU3TTBtei9VWjdmQ1JZ?=
 =?utf-8?B?dE1XVDFHZHIyTXc2T2M2TTlrWElWdFBsSnNXbmFYMThpRy95cXF0T0pQdElz?=
 =?utf-8?B?aGVHSmxEbE5kZFc2ZXJEL2lWazBGVkxrdzhUT1ZXY0cydGg5QS9WOFZKZHhr?=
 =?utf-8?B?UDlsZDB3MWxzQU9zU0R0c0N1ZGNSTmgwTU9iNmlYb1N2R2dTekV1NnBFZDBl?=
 =?utf-8?B?amdjTmltRzErQVpleGNNK0JpeEE4Y1BqQnN4a3MzYzdQU1JEZGJGejNudndS?=
 =?utf-8?B?b0M2OThUd05qMmpZaG53elVuRGd5WGNnOXpHVndPTnFMMk5HQUJFRkUrQ1B1?=
 =?utf-8?B?Zk4yUWVQWU01VkJXdTZIS3Rtbmd4cDdKdjRkTmZUMEl0UmR3MkE5anVnM1BR?=
 =?utf-8?B?TnpZVElGbVkvSzhvMUE3TDhCYlJaVGVXV0U4TmtXR3AwWEZJNUowUGFFMjJn?=
 =?utf-8?B?TGVBaE1LdkpsR3VDV1BzSFBGMFVmVnAyUG5SOThCUGE2SGZnV1JUTHY2c3VF?=
 =?utf-8?B?eUdiSHZsdjZoOU1WcW9HdXpaNEoza0djSWZtRE9kUzFydFJkVXpHYzMyUmU1?=
 =?utf-8?B?Z2JLWnIrUUdrbjMxUWRwVVViWGw4VW8rdUkrRlpvT1RxZFZ0UnMrWDBtZlJF?=
 =?utf-8?B?OTVqK0sxMHYxcW5CVTRhdUlyVmlnZDRCTzJHL3lqdFBNK0RvVlRBTkpLVWsx?=
 =?utf-8?B?RXdnWlVhL1B1emRyWTRiVTdMeTRtRkE1VmFTdHJwZkNUV0tkWWFzNFpxcVU5?=
 =?utf-8?B?VXRBRy95Zy9tck9hTzljMmE5dWRiS1RYYmpsbzRidHIrQjNVTTF3RTFla3dS?=
 =?utf-8?B?bjdDRjE3Y0o5TlBja20zbThoN1lDTzFwSFJRMUdqclVzb3ZBUTZrZTFNVjdq?=
 =?utf-8?B?UkF3dTNRdjk1T1FEbS9pZEp2N3AvRFBGVkxiR09qU3RHV3B4RDd4MkJiSlk1?=
 =?utf-8?B?WXRBYUl6azAvTTQ1UVNCcHpodkxLWXdEQ3ZqZ01jL21teGFEYmpBczV0UjRP?=
 =?utf-8?B?cERzajJTSGEvMllCZEJKSmNpUG5MUUQvM2tOWWQ4aThSZkJLQkM2RXdCUjNT?=
 =?utf-8?B?bDFFWkk2UmN3aWxmY2lyQURvZ3ZwTURzQjZSdWNFUlVydUxiVnNsR2FHdjJT?=
 =?utf-8?B?SGhQZGY0eXZ6T0lmV1FHa3hqMHBhNnNvK3YxZkIzcStaZU1sbTE2d21VM25L?=
 =?utf-8?B?czJ5RjdXN1NLZVVuOEcrbm1HSmVzZ2NhN3Ria0F2Q3U0M2JmUm94YUx1TFA0?=
 =?utf-8?B?TlVkWENHNVpKQk9mbjd5QWNUTmxRUjlNNkxRZ0Z2cGdWMlh5RG1RK0crZDZ1?=
 =?utf-8?B?Nk5NMFlrSTlUV0cvUFR1ZmdLY1hmSFhrR21Cc1d2bFpKYTYzcmpwZXhPQXFk?=
 =?utf-8?B?Uzl5bXdDZzl1aE5sSmtHRGFNMUhXNmVIZXpaM0xVUmQ4bVQwMWljNjVZWFYx?=
 =?utf-8?B?UDVjNnNlazFJaE1SQk1OUmN2emhiM3JGSFFYTjRVdkRUYkJ0ODhqNXFON2ZS?=
 =?utf-8?B?UTJ4eHFiV2pVaVg0K2dBVUFyYXpTTDEyZXNWUUh4SjhIUmErS3ZOVXU2YlRL?=
 =?utf-8?B?K2U3U0YxUTJ5UWdjOXlMVE95SFViY0lXZzZpT3Ztc2xKYkw0YS8vdFFZYlNq?=
 =?utf-8?B?L2pwdm1JY01jQzRyaFRuV0JnSGptSUFkRStmRUE3N2dwQlhQbHFRRFVtSmlX?=
 =?utf-8?B?UjZLTjl3VDBVTU5UZ3FheXNkNDhocE9ndmJJREtKR3ZLS0diMmw3VVl1eGd1?=
 =?utf-8?B?aGloeTJDdDVUK0xqNU9vV1E3TFdaSDcxMlhMRVZra0V1K1BGME04ZkNQMUdL?=
 =?utf-8?B?MTg2VUFLa0Qva0xwTDV5Rkg1Q0U1R1VwNjVJY1hHWGw3Ym5xYU5sd3dOZ0Y2?=
 =?utf-8?B?a1k1QjZNQ3dmVGhaQy9jWSt5M2pvSVljQ2VrR3F2eS9RdGdFT1NMSEVVTTcr?=
 =?utf-8?B?RERxTlJBR2pQOVk2K0dsbHNrdERHeDJ1M2dXcGJuY0hrOCtERzB6c2RHRFJt?=
 =?utf-8?B?RzNScjkxZTVEcUNnZGZDdnBMcURFWXRzQ2l4VFE0ZlJ4NnEvTjFJM3Niak9X?=
 =?utf-8?B?V0pObW9NdHZUUkh4bFRtQWtUMGd3ZkRSS2p4MVNCWS83UGQrV2dFcFRSZnJ0?=
 =?utf-8?B?dnFGUjRmbUZ5dlorTXZtRnpsSy85RkVBMHRkMklUL2VuUmllS1JDOWhwaHF1?=
 =?utf-8?Q?ZCPIFkLcU0VjSwkFzenT0Xo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB8373.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003)(7053199007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmtHQkZ4MXI0VmJIWWVGODc2bkp0S3pSNTFGTjRsaVZhcFVyc1VkdEM5Z3dB?=
 =?utf-8?B?VFBXQ0I4eFRJR2x0L0VxS3dsUjY2YjVtR0NTZWNWSytlZ01Ud3AvbmV2TXkv?=
 =?utf-8?B?OWlnNjhYRE9aYVAzWEpSaS8xdWJVUTRKRW1IZlFoRHVnNU1kV0RvVWc4WEFY?=
 =?utf-8?B?OW5OblRkQU5ENDZmZFl2UnBEY2FOZXd1Q2U4UktEMVRMMzhick1LRktXTDhX?=
 =?utf-8?B?Rm1pRFJnb2ROWHNsU0d3MEJIT1FTc2k5bmh0YklTVVVMSHNIZmVhQnJmbjQv?=
 =?utf-8?B?U0Zqd0Z1aWc4RGpHQU96R0s0WjBoUFJjbUNScjZyRUpraERHR3BvYVlsYkVR?=
 =?utf-8?B?V3RyMnl4UTFaRnd3M1FFRUxPY3RyZ05idjhHK05lT01YV2xHeERjTVhiQmtX?=
 =?utf-8?B?L1UyR21GYzNEUk5KdGsyYnl5NDZQL1NSUWRKUlhwbzBPa2xoSnRxRmZWQi9B?=
 =?utf-8?B?bmVzQXNXY3lmWHJWRlRYNXd5Zmp0THdhK0QzVUpkaUdVZ3h0Wk8wWG9EbGpF?=
 =?utf-8?B?Yi9UYmUySmhoMnlYeFYycERXU1pIZmNHMG5idVgySjVyc1BFcks0OXg3dmMr?=
 =?utf-8?B?VnBuL0o4aVNOelhmU1F5ZmdlZC9sTHVWTGYvLzFBbDdmQTE2R1pXZTF5UERu?=
 =?utf-8?B?ZUE3K2w3T1ZVNjZKbVJRMUxsOWdNcW1xWHhSYTcvbXRleno2dlJhZkhKNjcx?=
 =?utf-8?B?bnJBdDg3bW05cE5kSWhOZjlnL1Q4NHFwUWhlbFlZUll6RUlZQU55R3NkUjh2?=
 =?utf-8?B?NGxRV1ZmVysrZ3piczUzYkpBdU1MVEFZaGJJNGdTS3pvMTdTYS9rdDhhd2ky?=
 =?utf-8?B?SjljdTBxNDdPRHdTbCt4L1NEUXM2S1NNbXdyVWhsaTZObG1qOVd3Lzk2MXNW?=
 =?utf-8?B?MTg5OG5MSVlpaVlWaXdFdkk0bFc3bDhXUWZ5L1VZa3Jqdm80RDFhS2NoOVBr?=
 =?utf-8?B?NFoyaUdvNjVIbDMxZHdGYkJPNFlObEtydi9ad2xRTTcxVWNlQ1lKVWdEdkRB?=
 =?utf-8?B?SmZIZzZmSUdjSzFyTGFOVFp1a282ZndxcTk0YWVUL3RQM29KNFEvVzFySXUy?=
 =?utf-8?B?V0RlRytCNlA2QkVXT21JZ0NsRXlFMVV3L2p2eUxKWlJ1dm9KRDhGYUZrbS83?=
 =?utf-8?B?clJjajNwK3Q2UmZlc3hYSml5azdwNElMWW4rSDFiWitCSFFYZjVsZ254TDB4?=
 =?utf-8?B?SUlaNktMdXZaMFZvdGxvQnh1QVI3eFY5UXVUTldES1hURngzQVkrcFZ4eWJ0?=
 =?utf-8?B?cHZUc0poOUJ0SE5EVzIwV1ZHV3NQeXV4S0ozY3N2QXZHUDR4L0tDZDFIRWFL?=
 =?utf-8?B?R3Jrb2xYSWFEQUJCWXp4cWU4ekZGaUlJRGVUZ3NVdE9rZ3R3cWd3ODR2Z1dZ?=
 =?utf-8?B?Nkkzell4K2p1MTYwd2N2clJTNCtJMkFWN3VsUzY1aDAwVW41azQ1VytUQ0Fr?=
 =?utf-8?B?RURjc0UzancwMzVZbzFHRFY2TjJpM0hhbHc3MWhxa3czajhSYW9tZWZNbUhB?=
 =?utf-8?B?bERUbUJYVkN1MXBmMlIwK0VLaHowYVhITzRLZisrSVNKT2gvcGNHditvN01E?=
 =?utf-8?B?R1AvZjRma0ozUEd4WTgzbVNtZGhSRUtuSVRyN0xXL25pNlEyWVhVckdRK1Ni?=
 =?utf-8?B?ZjZOS3ZCUWVKTmhzUThaczhTSEpOdjZNSkxKNiswbnZFME1ydW80S2JWSktZ?=
 =?utf-8?B?YnEzMnhyak5NckdFaGl3NFJiUCtwZE9kZDlvRTVQekxGNTVnaldqT0xaT1Fq?=
 =?utf-8?B?dnlZQnUxcnBKd1JNejhYa05UT1hOOVNjK1kvWk5palV0WXIxL2dIQVR5bTVG?=
 =?utf-8?B?WjNvQTdyYUpFMEM2K3cxMlcvbEZWWThGL2xpaWRRN0JyNVBPT1FhWWxyWVFk?=
 =?utf-8?B?SGRnUzIxMlB2RUlxT0ZPUG91L3hxeUduODZNZ2JpdlJZZFhhS2Njb0ZjdCtn?=
 =?utf-8?B?TkFBc1FETnBiS01tK1ppdDc4WTdEeUFKN0RoMDRRaHlHbjdaMFk1WjJHaG9J?=
 =?utf-8?B?aW05MG5MK3B4cVEyZTRmdXBLbm9vbFpVbEN4WXlFU1BzMHpQdFdJbTVJZjV2?=
 =?utf-8?B?RUhMTENqTGptTGpOT0l2MlVqRzdZaUZxZGNoa09NZ3ZhRlhnNnNIdGNjWHpO?=
 =?utf-8?B?RldTTS9NQmVZcnd6RnQxM1JpUm00T3Bidng1QXc1cFcrMW56Z3cvdmFkcU1K?=
 =?utf-8?B?b1BsU001ZWFFWmxBL1hEeTBmMFhla0ltcnJ5K3JsdWpsdTFzWlBwWmtkanl4?=
 =?utf-8?B?WDJoZWNWbDl1amRsY2FHZktveUZpWlRuV1lUZVpUN3JTUlZ0aFVOMzl1dExy?=
 =?utf-8?Q?H/+SGE2K2SDdRym5nn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wacom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB8373.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1691cff0-cfa6-40d3-ce1d-08de6447115b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 23:42:32.9427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9655a91b-107e-4537-834e-d15e84872626
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtq0WOWZbMTNEkESd24MZXzT/UEjNTL2/Ouu0kXEkixSAva/ZQEKD7donNk7DRE7TpXa2fkqusoe+PT7WBBFug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11230

VGVzdGVkIGJ5IEVyaW4gU2tvbXJhIDxlcmluLnNrb21yYUB3YWNvbS5jb20+DQpSZXZpZXdlZC1i
eSBFcmluIFNrb21yYSA8ZXJpbi5za29tcmFAd2Fjb20uY29tPg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBUcmFuIDxhbGV4LnQudHJhbkBnbWFpbC5jb20+IA0KU2Vu
dDogU2F0dXJkYXksIEphbnVhcnkgMzEsIDIwMjYgMzo1OCBQTQ0KVG86IEppcmkgS29zaW5hIDxq
aWtvc0BrZXJuZWwub3JnPjsgQmVuamFtaW4gVGlzc29pcmVzIDxiZW50aXNzQGtlcm5lbC5vcmc+
OyBTaHVhaCBLaGFuIDxzaHVhaEBrZXJuZWwub3JnPg0KQ2M6IENoZW5nLCBQaW5nIDxQaW5nLkNo
ZW5nQHdhY29tLmNvbT47IEdlcmVja2UsIEphc29uIDxKYXNvbi5HZXJlY2tlQHdhY29tLmNvbT47
IEVyaW4gU2tvbXJhIDxza29tcmFAZ21haWwuY29tPjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBBbGV4IFRyYW4gPGFsZXgudC50cmFuQGdtYWlsLmNvbT4NClN1YmplY3Q6IFtQ
QVRDSCB2M10gc2VsZnRlc3RzOiBoaWQ6IHRlc3RzOiB0ZXN0X3dhY29tX2dlbmVyaWM6IGFkZCB0
ZXN0cyBmb3IgZGlzcGxheSBkZXZpY2VzIGFuZCBvcGFxdWUgZGV2aWNlcw0KDQpbWW91IGRvbid0
IG9mdGVuIGdldCBlbWFpbCBmcm9tIGFsZXgudC50cmFuQGdtYWlsLmNvbS4gTGVhcm4gd2h5IHRo
aXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQoNCuKaoCBXYXJuaW5nOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBhIHNl
bmRlciBFWFRFUk5BTCB0byBXYWNvbSEgUGxlYXNlIHByb2NlZWQgd2l0aCBjYXV0aW9uIGFuZCBE
TyBOT1QgQ0xJQ0sgbGlua3MsIG9wZW4gYXR0YWNobWVudHMgb3IgcHJvdmlkZSBhbnkgdXNlcm5h
bWUgb3IgcGFzc3dvcmQgaW5mb3JtYXRpb24gdG8gdGhpcyBzZW5kZXIgdW5sZXNzIGl0IGlzIGEg
dHJ1c3RlZCBzb3VyY2UuDQoNCg0KVmVyaWZ5IFdhY29tIGRldmljZXMgc2V0IElOUFVUX1BST1Bf
RElSRUNUIG9uIGRpc3BsYXkgZGV2aWNlcyBhbmQgSU5QVVRfUFJPUF9QT0lOVEVSIG9uIG9wYXF1
ZSBkZXZpY2VzLiBWZXJpZnkgSU5QVVRfUFJPUF9QT0lOVEVSIGlzIG5vdCBzZXQgb24gZGlzcGxh
eSBkZXZpY2VzIGFuZCBJTlBVVF9QUk9QX0RJUkVDVCBpcyBub3Qgc2V0IG9uIG9wYXF1ZSBkZXZp
Y2VzLg0KDQpNb3ZlZCB0ZXN0X3Byb3BfcG9pbnRlciBpbnRvIFRlc3RPcGFxdWVUYWJsZXQuIENy
ZWF0ZWQgYSBEaXJlY3RUYWJsZXRUZXN0IG1peGluIGNsYXNzIGZvciB0ZXN0X3Byb3BfZGlyZWN0
IHRoYXQgY2FuIGJlIGluaGVyaXRlZCBieSBkaXNwbGF5IHRhYmxldCB0ZXN0IGNsYXNzZXMuVXNl
ZCBEaXJlY3RUYWJsZXRUZXN0IGZvciBUZXN0RFRIMjQ1MlRhYmxldCBjYXNlLg0KDQpTaWduZWQt
b2ZmLWJ5OiBBbGV4IFRyYW4gPGFsZXgudC50cmFuQGdtYWlsLmNvbT4NCi0tLQ0KQ2hhbmdlcyBp
biB2MzoNCi0gYWRkIGFzc2VydGlvbiBmb3IgcHJvcCB0ZXN0cyB3aGVyZSBvcHBvc2l0ZSBpcyBu
b3Qgc2V0DQoNCkNoYW5nZXMgaW4gdjI6DQotIFJlbW92ZWQgdGhlIHRlc3RzIGZyb20gdGhlIEJh
c2VUZXN0IGNsYXNzDQotIFJlbW92ZWQgZGlzYWJsaW5nIHRlc3RzIGZvciBjZXJ0YWluIHN1YmNs
YXNzZXMNCi0gTW92ZWQgdGVzdF9wcm9wX3BvaW50ZXIgdW5kZXIgVGVzdE9wYXF1ZVRhYmxldA0K
LSBDcmVhdGVkIERpcmVjdFRhYmxldFRlc3QgbWl4aW4gY2xhc3MNCi0gTW92ZWQgdGVzdF9wcm9w
X2RpcmVjdCB1bmRlciBUZXN0RFRIMjQ1MlRhYmxldA0KLS0tDQogLi4uL3NlbGZ0ZXN0cy9oaWQv
dGVzdHMvdGVzdF93YWNvbV9nZW5lcmljLnB5ICAgICAgfCAzNCArKysrKysrKysrKysrLS0tLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaGlkL3Rlc3RzL3Rlc3Rfd2Fj
b21fZ2VuZXJpYy5weSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2hpZC90ZXN0cy90ZXN0X3dh
Y29tX2dlbmVyaWMucHkNCmluZGV4IDJkNmQwNGYwZmY4MGJlYTQ2ZGM2YzYxYzJiM2E0MzM4M2Jl
NmFjNTAuLjM5MDNmNDc5YjE1YmRmODkzN2E5ZjFhZTk2NzkxZjZkZWUwZjg5YjcgMTAwNjQ0DQot
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9oaWQvdGVzdHMvdGVzdF93YWNvbV9nZW5lcmlj
LnB5DQorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9oaWQvdGVzdHMvdGVzdF93YWNvbV9n
ZW5lcmljLnB5DQpAQCAtNTk4LDE4ICs1OTgsNiBAQCBjbGFzcyBCYXNlVGVzdDoNCiAgICAgICAg
ICAgICAgICAgaWYgdW5pdF9zZXQ6DQogICAgICAgICAgICAgICAgICAgICBhc3NlcnQgcmVxdWly
ZWRbdXNhZ2VdLmNvbnRhaW5zKGZpZWxkKQ0KDQotICAgICAgICBkZWYgdGVzdF9wcm9wX2RpcmVj
dChzZWxmKToNCi0gICAgICAgICAgICAiIiINCi0gICAgICAgICAgICBUb2RvOiBWZXJpZnkgdGhh
dCBJTlBVVF9QUk9QX0RJUkVDVCBpcyBzZXQgb24gZGlzcGxheSBkZXZpY2VzLg0KLSAgICAgICAg
ICAgICIiIg0KLSAgICAgICAgICAgIHBhc3MNCi0NCi0gICAgICAgIGRlZiB0ZXN0X3Byb3BfcG9p
bnRlcihzZWxmKToNCi0gICAgICAgICAgICAiIiINCi0gICAgICAgICAgICBUb2RvOiBWZXJpZnkg
dGhhdCBJTlBVVF9QUk9QX1BPSU5URVIgaXMgc2V0IG9uIG9wYXF1ZSBkZXZpY2VzLg0KLSAgICAg
ICAgICAgICIiIg0KLSAgICAgICAgICAgIHBhc3MNCi0NCg0KIGNsYXNzIFBlblRhYmxldFRlc3Qo
QmFzZVRlc3QuVGVzdFRhYmxldCk6DQogICAgIGRlZiBhc3NlcnROYW1lKHNlbGYsIHVoZGV2KToN
CkBAIC02NzcsNiArNjY1LDE1IEBAIGNsYXNzIFRlc3RPcGFxdWVUYWJsZXQoUGVuVGFibGV0VGVz
dCk6DQogICAgICAgICAgICAgdWhkZXYuZXZlbnQoMTMwLCAyNDAsIHByZXNzdXJlPTApLCBbXSwg
YXV0b19zeW49RmFsc2UsIHN0cmljdD1UcnVlDQogICAgICAgICApDQoNCisgICAgZGVmIHRlc3Rf
cHJvcF9wb2ludGVyKHNlbGYpOg0KKyAgICAgICAgIiIiDQorICAgICAgICBWZXJpZnkgdGhhdCBJ
TlBVVF9QUk9QX1BPSU5URVIgaXMgc2V0IGFuZCBJTlBVVF9QUk9QX0RJUkVDVA0KKyAgICAgICAg
aXMgbm90IHNldCBvbiBvcGFxdWUgZGV2aWNlcy4NCisgICAgICAgICIiIg0KKyAgICAgICAgZXZk
ZXYgPSBzZWxmLnVoZGV2LmdldF9ldmRldigpDQorICAgICAgICBhc3NlcnQgbGliZXZkZXYuSU5Q
VVRfUFJPUF9QT0lOVEVSIGluIGV2ZGV2LnByb3BlcnRpZXMNCisgICAgICAgIGFzc2VydCBsaWJl
dmRldi5JTlBVVF9QUk9QX0RJUkVDVCBub3QgaW4gZXZkZXYucHJvcGVydGllcw0KKw0KDQogY2xh
c3MgVGVzdE9wYXF1ZUNUTFRhYmxldChUZXN0T3BhcXVlVGFibGV0KToNCiAgICAgZGVmIGNyZWF0
ZV9kZXZpY2Uoc2VsZik6DQpAQCAtODYyLDcgKzg1OSwxOCBAQCBjbGFzcyBUZXN0UFRIWDYwX1Bl
bihUZXN0T3BhcXVlQ1RMVGFibGV0KToNCiAgICAgICAgICkNCg0KDQotY2xhc3MgVGVzdERUSDI0
NTJUYWJsZXQodGVzdF9tdWx0aXRvdWNoLkJhc2VUZXN0LlRlc3RNdWx0aXRvdWNoLCBUb3VjaFRh
YmxldFRlc3QpOg0KK2NsYXNzIERpcmVjdFRhYmxldFRlc3QoKToNCisgICAgZGVmIHRlc3RfcHJv
cF9kaXJlY3Qoc2VsZik6DQorICAgICAgICAiIiINCisgICAgICAgIFZlcmlmeSB0aGF0IElOUFVU
X1BST1BfRElSRUNUIGlzIHNldCBhbmQgSU5QVVRfUFJPUF9QT0lOVEVSDQorICAgICAgICBpcyBu
b3Qgc2V0IG9uIGRpc3BsYXkgZGV2aWNlcy4NCisgICAgICAgICIiIg0KKyAgICAgICAgZXZkZXYg
PSBzZWxmLnVoZGV2LmdldF9ldmRldigpDQorICAgICAgICBhc3NlcnQgbGliZXZkZXYuSU5QVVRf
UFJPUF9ESVJFQ1QgaW4gZXZkZXYucHJvcGVydGllcw0KKyAgICAgICAgYXNzZXJ0IGxpYmV2ZGV2
LklOUFVUX1BST1BfUE9JTlRFUiBub3QgaW4gZXZkZXYucHJvcGVydGllcw0KKw0KKw0KK2NsYXNz
IFRlc3REVEgyNDUyVGFibGV0KHRlc3RfbXVsdGl0b3VjaC5CYXNlVGVzdC5UZXN0TXVsdGl0b3Vj
aCwgVG91Y2hUYWJsZXRUZXN0LCBEaXJlY3RUYWJsZXRUZXN0KToNCiAgICAgQ29udGFjdElkcyA9
IG5hbWVkdHVwbGUoIkNvbnRhY3RJZHMiLCAiY29udGFjdF9pZCwgdHJhY2tpbmdfaWQsIHNsb3Rf
bnVtIikNCg0KICAgICBkZWYgY3JlYXRlX2RldmljZShzZWxmKToNCg0KLS0tDQpiYXNlLWNvbW1p
dDogNzliOTVkNzQ0NzBkZDk3ZDdkMDkwOGQ1YTNjMDczNGEyM2U1MWFhNA0KY2hhbmdlLWlkOiAy
MDI2MDEzMS13YWNvbV9zZWxmdGVzdHNfZGlzcGxheV9vcGFxdWVfZGV2X3Rlc3RzLTQ1MTljNDAw
MTQzYg0KDQpCZXN0IHJlZ2FyZHMsDQotLQ0KQWxleCBUcmFuIDxhbGV4LnQudHJhbkBnbWFpbC5j
b20+DQoNCg0K
