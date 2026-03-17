Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1CEEB3;
	Tue, 17 Mar 2026 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717294; cv=fail; b=DIEvzk+CsiG87alD9BB9lVjcrB9WpBEky6+yRayipgU7kVuKxr7aPRfGZm9kV9f3oS6J0hXhqvohEYovQkm2t9LRgGeeDtM4QNyfI0T5ZVjfQnSzHjP8CSLLQt+Y8zTujd/mZ1o3ExAwTtcFS3xN2uVdwfJW919GH7QtvJGFXPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717294; c=relaxed/simple;
	bh=a9t/wWqJihvtVAWsSkwPv+LMXkxZ06QheihFq5NjUMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOCgJIW2lya+WmkLdKNV9ow26Vm5kuZB+MGxaPMiwJ2yLbC9U9YL7kEpbF21kCXPVfRHnl7V6e4DFo5meXAdTdJI5M8XA1mGf9V9cDRI3RZLV+I9S0arDLA7nqiAWmIGX7+Ej7XgPzzXbTO2uHvhNh7+rCrPVB6Gba/ViUwAKM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ebb0eIWN; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ebb0eIWN"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H0rdKd3761556;
	Mon, 16 Mar 2026 23:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=a9t/w
	WqJihvtVAWsSkwPv+LMXkxZ06QheihFq5NjUMU=; b=ebb0eIWNU8gQtqb8ZMbAZ
	qkZ9wd0uy+eobzeiv6f/ThYdGihYqaMePAOakejw6ctxWQMJ4BG/z6YfRZzaZW9g
	Df+HNUsbZHRX2kMw+ee8Rmem3uU6hkx9bOjcWrBZCsJhpmwlkuXtdMmbzJlzBVum
	enXK9NDttk4z72V04Fj1iRX3aoQLDkSTlBHxXsTLGWx/OW+ssCfE4K6BBJLvowGS
	DfXYVejmF8WK99YnuIEc+v9iVpUDtLXLQj8RTJOv7rk4dVMIhR+X3I5dAkfVN9XH
	2EbFroV/u8co1K8ooHXLswQ/m2fyP6OsqD4YfvQ0C0XbRi01k1RfJ+9H6f/Cwkf+
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cws0fq5p7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 23:14:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkWMdCkHoSo8VcEbmkNknzgJGIFGshlrHDHGNyy94XV8DIKA0QUu7gJeAOU/PGB+PwPWwr+Eq6f5hqZ9sNNNcqkBeNP4rmRZq2xfBFYSOnvC4tcLphd09Z6xZHZQtkI8+RWFyb+eAIIiEVeYsC/LPAZ0YvlzWIHw0/8nTT47X4NO99Zoc4csnFheyCeH/tbj6zJcA6D0JxxydtKbOFQf9+wbtu1rA4riYQPcYAxbavDLC1RRPAxNojqXfRgiXh7U3NjModmTI3/b4MHawN399TlgI2ILkF8CuIsveZIEic2+G3kA7bwS5SYn46SGvzAsBFBDpuAtI5TImsVRloaIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9t/wWqJihvtVAWsSkwPv+LMXkxZ06QheihFq5NjUMU=;
 b=mtgcVj1HqNqDCHHYraXhFx+g9yX4q/hNTd7sRpacBwTN2NxVECWt1o180ea4J2gtYMlS5ZaYy/5DdXIQGPjsVchPwmO4aJ3+DPIxkUAMR3B7vZFKjshkwJdK1WbNQ+SGo5AFFh/EsaDkB+D+OrKpKDucV1J7r//od6uUvfg+WFLVY3n3+CEipHnRNLmxmxzIWOOro69PNQrJSutaxtQIGVH+fTga9kE9CfIPOoYqaAIOD53dZ0fyYzW3/z/ndPv/7TdfA/zbURRUpvUQ+hZc/svEVEvNgITJjJJM3VDLzDKBNOfwFPwJmbpz3VwUvOVENV8JXxrY8UvhBF/A3rlujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BLAPR03MB5619.namprd03.prod.outlook.com (2603:10b6:208:284::16)
 by BL4PR03MB8037.namprd03.prod.outlook.com (2603:10b6:208:58e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 03:14:29 +0000
Received: from BLAPR03MB5619.namprd03.prod.outlook.com
 ([fe80::8d8a:17a3:6fa5:2be1]) by BLAPR03MB5619.namprd03.prod.outlook.com
 ([fe80::8d8a:17a3:6fa5:2be1%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 03:14:35 +0000
From: "Sosa, Marc Paolo" <MarcPaolo.Sosa@analog.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: input: add adi,max16150.yaml
Thread-Topic: [PATCH 1/2] dt-bindings: input: add adi,max16150.yaml
Thread-Index: AQHcpLQa2+zJTK1CXEWXYMab+trvX7WQNW2AgCH5Z0A=
Date: Tue, 17 Mar 2026 03:14:35 +0000
Message-ID:
 <BLAPR03MB5619DC485B0D0D924938E0CCFF41A@BLAPR03MB5619.namprd03.prod.outlook.com>
References: <20260223-max16150-v1-0-38e2a4f0d0f1@analog.com>
 <20260223-max16150-v1-1-38e2a4f0d0f1@analog.com>
 <177184949524.3256996.10057873509160996630.robh@kernel.org>
In-Reply-To: <177184949524.3256996.10057873509160996630.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR03MB5619:EE_|BL4PR03MB8037:EE_
x-ms-office365-filtering-correlation-id: 55478557-573f-4d20-64c3-08de83d350d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 be8Rz3Y5VzJ824ZMhTVdgk+YCqbqG6UwnoZeSxIZPBhbe5xG6hQJgVUOhRoM7f/OENzMBzPaQUhg46kYaprqxIp4edY/3xdbHIi2cdX6Y1kB8NlKDO1beWEYE5hpmTWNG2yketk9ren03TvjAyV6hCIsbZ72b1nrbL7pwohANlS1wjs/iGKM2vmwxjJnfOAE6rWWijX+mM4lna/VmHaxS4imMbe6mQqoUCcobawR2Kr4bNF+QXSfTX1bZVbQo7he1FWEf7EEj1BJ1xrb0zrNF6pO72zT3AqfVFJzvluQNuTKf/6f+dkJkudzahVvzeoCc9AORVexVJAHe6BIZj2MWgzWyTaZWt3aJVDJktV//KoG+42hCzqbgSdY+uVhkUFsvCk+BgL/A2lMPaK0EFO+lMzHYrBN/5lk4BEeQiXnI6nu6dT2YaFeFYHdNdIJB5WozORpKMwejb5cLy72HWwzIJEb508jp+ZNYbCC1sDeMD3RLu1/502OAU0cyv0VEAhyiN7fLke4hPlfMKGaA20ewxKeQLBigN5uMRmWxnhF+LWVlH5YvZ2hkK5LtUMAnyy+W4z8avg/twe4tn7neDrPermc8wNx1ijvxEicMeHM8Q53FsCKsdDqHvR2o6BMSHi+LbT0a1ruTlLnraaLl9k4dEtWeg14pUm8fqm4zcJXg9CwtG0uGKtuwiuke82noxhOyAcAlvtOSYCL3mWZFtZ+zkcSY8NQ1GVZnUyDao8c0ICzzHRmhKq49Lz+IG6fzCM4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5619.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rnc1Z2ZzSzExTDY5TzlwbW1zUHd2UEY5OVZCU3A1MGFuYXFNNnlVbVU1Z3BX?=
 =?utf-8?B?T0laK1lXTE5mRlZvTmY4MVZNYVRVWE82ZGtuVmNlMG1NKzdTY3hFU1Y0TGh1?=
 =?utf-8?B?YVIvaFlXak9UR3pKdUpoZlROdFRoQUdIYXJpU0Y2bkorbHptZnJWMVBRVjRM?=
 =?utf-8?B?U3VrOWlPMVBlK3JFemJ5VDU3Z2piREl1eTNocGl2aG9zWC9aYmQ0VUgrN0l1?=
 =?utf-8?B?WFpkRnhlYjZoTGdGcG0xbjBnQUtacnV6Sm03N04zcUxCQy85ZTlqcmlkS0ZB?=
 =?utf-8?B?MHJEcUpQT1paNXpvSG5xZ1h5V3JuQzhURnQyZVRoM2h5MUlYYXJPU3pGZ01E?=
 =?utf-8?B?cDhGYlo0NUdsZm9VUjRSclBWZHp2RnNFTXdQNEp2NndYZ1p1MUlTTm9BdDc3?=
 =?utf-8?B?U2UzNkR2WEhQTEQxb3I3QytaalBKd0xLWU1BYjdqZkdYeXBDbEdTOTIvaFE0?=
 =?utf-8?B?d2o0MFdUYjdRYTM0QjM5MDNxLzNhNFlWaE5sSitESklWSUZaRU14WVMzOE5r?=
 =?utf-8?B?dGxoSE0zR1pibGhCWkQyNTE4aFVDd3JYc2ZhanliMFR4cWFpRTh5VWJHSDAw?=
 =?utf-8?B?RnU4TFpDUnZacVgwOVp3cWl3bmFXNlpMZFpTY2pMbEN4OG9BNjl5NnVnSnVY?=
 =?utf-8?B?dlJncXp6bFFZZ0NOcjA1Q2I3YzlDQklwMUFzODJicnA2WUJxVDFKaFNLdFYx?=
 =?utf-8?B?OU1MUWZuK0R0Z0kwN3FpWDdzVHNadk85bXlod1RpNmxtOWZqWUtuaS9VbEtr?=
 =?utf-8?B?RGZMNFh1R0VjVGJNUjJWaEhPTXZqUzQrOUFMZS81cnJFWUFQaHN0WW1jWk5K?=
 =?utf-8?B?amNuL0g3ZTZuWWJLaUdXdW5RcHIvRUl3NGZZU05Sand3M1dQcHg0MU5OQnF0?=
 =?utf-8?B?STkvcEdjRmdiQUJLTUx6Yi96SlN0cm1MTzFRTzZEWUhLZWRrb0tvSHcwb2Iv?=
 =?utf-8?B?UmIyWnVYRS9WRTJJUTNXS0dIMDYyZXlpcjJCRitPOTVzdHdDcUJNZWdHYUw0?=
 =?utf-8?B?WndZeW4vWERMRHMwdnhHYmZTMUwvNlFRSzdhZnNGc3dWMGdrSG85dUQ4U0hH?=
 =?utf-8?B?dGVqZkxMdlNNS240d2F2dGRRVWlBTWcwRG5Ganl0bEo5OVhVTFdvQW54OStG?=
 =?utf-8?B?Q04rSHlhZDU2bWtHT09MdDFoWm8zVmt2QzR6MUcrSFowcVZaQjdDWFRQRWQy?=
 =?utf-8?B?RlJuZG1hMUVBOTQxUXJDeG96RVBDc2lZNTVzdU5qUmNYSjA3SDVkMFltc1dE?=
 =?utf-8?B?d01yV0orTGNDdUNQUVZiY1ppTnpCc0FLWkVzQk1VU1lJeHp2cktySUVyM0Yx?=
 =?utf-8?B?M2E5R0NhbFN5ZldmRW01dlpQODNmY2JLKytwVjdDelZ4VUdkRkRmVURMSVdK?=
 =?utf-8?B?K2pWNmdVNDZsRU14aGFLVXVyN3ZWanQrTWxxYVBQY3RRQUV2bTBKaVkydlJR?=
 =?utf-8?B?OStaYTRKMTljcnk5QmVKZGlCQ2RZN3JQOGF2TlVidG45TW9wMWNoVmlXWWhS?=
 =?utf-8?B?aHJkdlpOd1dHUFB5a2NtbFQ5Ym1ra1BFcWxIWVo0NWFjWkhyU09xVldXc0RV?=
 =?utf-8?B?cXJ6a0l4SHlOaU1ZRmFWVkpCS0pNc2pNZ2NHKzczZCtkRVQvajhndHRuRFF6?=
 =?utf-8?B?M3FJdExKeTZ4TysrWm5pa2l6VGhSaVZndGQzOU8xSnJtN0oyZnYvU3FBVlNy?=
 =?utf-8?B?d2wyaGc1dXoycTJmYmdvemxGNTQ3VWUzSFg2d0lsT2VJVTJsZnpNLzU2Tk5S?=
 =?utf-8?B?U1M2NE80OGVnS2lSanVHZTBBQ2s2R3c5eXZwcUdxTXBOV0d6cVcxbTBnM0Y1?=
 =?utf-8?B?Zm1Da0dyYXpEOW1ycG5yaTRESFlhOWpoWjBySHR5N1Zpa0V4WG55VzFWbkRR?=
 =?utf-8?B?K0J6d1RJa0g1YXYyVHI3cmRGaDhGcFVSZ3pnYWsyMWtRMjdqREVVa1FrUHJ1?=
 =?utf-8?B?MHNKRWFLSkZUWnprUEtybXZPTWY2TTVHU3NwU01wZHprbVU3S1NUUXFONDNK?=
 =?utf-8?B?YnR4cmJlYkZUM2daVE53aXlUN3VOWDJpaEdBaW5LdlVRMm84Ti9aVXNxSm8x?=
 =?utf-8?B?MzNVRTc4aWJxcW9xSmI5cVQ5eHc4b1pmaVJpNFBUWU9IV0dUNStwY2EyM0pm?=
 =?utf-8?B?OVhSYkFlMDllR3g5SzdlYStXbzFhM21iME9ZakQ3WUptNnhaR295dnNnR0Z5?=
 =?utf-8?B?SmVBOTNuUUJYK3Y3SWpTNE5DN2FDTU9ENlM5KzVGUlJzZGdjMUpMMmhwYWZn?=
 =?utf-8?B?SlRGcmVFcDJaRE9hL1dOb3hvQ0Y1L3NJRmczdStMczhUUERjQisxT0twZ0pZ?=
 =?utf-8?B?K2EraWg5QWdKYW9Nd3JsaVdqdVlMMGMzeHpMaVlIak1nSEYySzNVQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	APTjqxhhFlVk21+w0UAUXps1/nsBvjPEy1yYrUi/PwShgM3Ys+iTXoUd4nDlBYL/qTKA29X7EmStqvlX/D5y98pBwF4uYTClaZekGLe3O14brJRjEH73vjzN/LB+CljIZQilieTT4h+oS/1MSTpcqF0VmvyubuaRlczmhsCNud9EIfVJNipGQF6N9bbuZm33+6odD76Zqwzo2bcqChCpT+IAZpKjX4C0xBKKsSP+4DCdn/AIWLzbm1ZQ5tLJmI1Q1Blsr/gJt9T/XQRjQhcCwYMztFNUEge9Nub5Bo90TkZ6abyavOdB2HGCpB6YjBgQ4Opdzr5nIn9jyAu6wV6JEw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5619.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55478557-573f-4d20-64c3-08de83d350d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 03:14:35.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFMBZw8LM0aCRSYC+tBzECbW8ZdeFeDOJAg0Rngi5A5b0MQc+sP1GvM0KNcBAA/MneKjYNKeFsOrdJJrB03TyEcIMVMTNWChvkAD6k/XMF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8037
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAyNSBTYWx0ZWRfX2BCcgoyDlufH
 weIXrt/e9MUzWCOJg7JIoIWCEthDPVAKLTgJaeNawvcTnT+zac0lAltgM0uVlyHhFDtqgdZ8MwY
 TzPyutxgRJ+4bTGp1qYsifZmdO3NXaUI9Cx1KAiuqU+boPUasdJ3RDQFiKboCphQYm9VioDSpsl
 IhVffhhEOzP2GYh7vUcY/Ew3UTs2xSCLxZBjSvy+g+PEW00Ef97P4TlKMhrmy/QL4aKmt7AZ/k7
 5rgINXLtjcBQSkJmOk2+GSkMLsa8Fmf2nmOiEn/KOSnn8HdfUEVG+wsOwiwozerOJtbe0cJAFbO
 7UdwtmRNDFDxtFrjIexdlhQvQE/avybMpYBqbaiS3MTuA4DinxGF711CVNy7fbxSZo5wNNOKGhD
 6fFhevGqiyYwxoYrdBXdrAKnI01Q5+mBN4gtzCIXbxL/i3gtdmr6CUye4k6O39tQyJrkfda2tEf
 vXKfq9Ujlu0CRGAMCgw==
X-Proofpoint-ORIG-GUID: d967FlmKS66HDDj1O9HJSulmlmCUd0zX
X-Proofpoint-GUID: d967FlmKS66HDDj1O9HJSulmlmCUd0zX
X-Authority-Analysis: v=2.4 cv=BbjVE7t2 c=1 sm=1 tr=0 ts=69b8c726 cx=c_pps
 a=ButkoIHTjR5vDxq5MUTXqA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=uherdBYGAAAA:8 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=0awkmHLjsCMGZ7zvgVIA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170025

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgKEFy
bSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAyMywgMjAyNiA4
OjI1IFBNDQo+IFRvOiBTb3NhLCBNYXJjIFBhb2xvIDxNYXJjUGFvbG8uU29zYUBhbmFsb2cuY29t
Pg0KPiBDYzogRG1pdHJ5IFRvcm9raG92IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tPjsgbGlu
dXgtDQo+IGlucHV0QHZnZXIua2VybmVsLm9yZzsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJu
ZWwub3JnPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyemsrZHRAa2VybmVsLm9yZz4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBpbnB1dDogYWRkIGFkaSxt
YXgxNjE1MC55YW1sDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gTW9uLCAyMyBGZWIg
MjAyNiAxOTowMzozOSArMDgwMCwgTWFyYyBQYW9sbyBTb3NhIHdyb3RlOg0KPiA+IEFkZCBkb2N1
bWVudGF0aW9uIGZvciBkZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgTUFYMTYxNTAvTUFYMTYxNjkN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmMgUGFvbG8gU29zYSA8bWFyY3Bhb2xvLnNvc2FA
YW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaW5wdXQv
YWRpLG1heDE2MTUwLnlhbWwgICAgfCA1Nw0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspDQo+ID4NCj4gDQo+IE15IGJvdCBmb3Vu
ZCBlcnJvcnMgcnVubmluZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOg0K
PiANCj4geWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5p
bmdzL2Vycm9yczoNCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2R0LXJldmlldy0NCj4gY2kvbGludXgv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2FkaSxtYXgxNjE1MC5leGFt
cGxlLmR0Yg0KPiA6IHBvd2VyLWJ1dHRvbiAoYWRpLG1heDE2MTUwYSk6ICdpbnRlcnJ1cHQtZ3Bp
b3MnIGRvZXMgbm90IG1hdGNoIGFueSBvZiB0aGUNCj4gcmVnZXhlczogJ15waW5jdHJsLVswLTld
KyQnDQo+IAlmcm9tIHNjaGVtYSAkaWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9pbnB1dC9hZGksbWF4MTYNCj4gMTUwLnlhbWxf
XzshIUEzTmk4Q1MweTJZIS1UUHNpcjBlU0kxN0dIWGk3Z0dlYUsxWGl6RkhmMGJmNlNiQUpkWDA3
WnR6LQ0KPiBuQWJGenFVcWt2Y3h1YTk1TlBxZmQ5RjloWUxtQ2xZbkQ0USQNCj4gDQo+IGRvYyBy
ZWZlcmVuY2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+IA0KPiBTZWUNCj4gaHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9kZXZpY2V0cmVlDQo+IC9wYXRjaC8yMDI2MDIyMy1tYXgxNjE1MC12MS0xLQ0KPiAzOGUyYTRm
MGQwZjFAYW5hbG9nLmNvbV9fOyEhQTNOaThDUzB5MlkhLQ0KPiBUUHNpcjBlU0kxN0dIWGk3Z0dl
YUsxWGl6RkhmMGJmNlNiQUpkWDA3WnR6LQ0KPiBuQWJGenFVcWt2Y3h1YTk1TlBxZmQ5RjloWUxt
TVdGTEMtQSQNCj4gDQo+IFRoZSBiYXNlIGZvciB0aGUgc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUg
bGF0ZXN0IHJjMS4gQSBkaWZmZXJlbnQgZGVwZW5kZW5jeQ0KPiBzaG91bGQgYmUgbm90ZWQgaW4g
KnRoaXMqIHBhdGNoLg0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdf
Y2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZSBlcnJvcihzKSwNCj4gdGhlbiBtYWtlIHN1
cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cCB0bw0KPiBkYXRl
Og0KPiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiANCj4gUGxlYXNlIGNo
ZWNrIGFuZCByZS1zdWJtaXQgYWZ0ZXIgcnVubmluZyB0aGUgYWJvdmUgY29tbWFuZCB5b3Vyc2Vs
Zi4gTm90ZQ0KPiB0aGF0IERUX1NDSEVNQV9GSUxFUyBjYW4gYmUgc2V0IHRvIHlvdXIgc2NoZW1h
IGZpbGUgdG8gc3BlZWQgdXAgY2hlY2tpbmcNCj4geW91ciBzY2hlbWEuIEhvd2V2ZXIsIGl0IG11
c3QgYmUgdW5zZXQgdG8gdGVzdCBhbGwgZXhhbXBsZXMgd2l0aCB5b3VyIHNjaGVtYS4NCg0KQWxy
aWdodCwgd2lsbCBjaGVjayB0aGlzIG91dCBiZWZvcmUgc2VuZGluZyBhbm90aGVyIHBhdGNoLg0K
DQpUaGFua3MsDQpQYW8NCg0K
