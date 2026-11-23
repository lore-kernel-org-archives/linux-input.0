Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795401582;
	b=46oUWjFPg1AKsP2MO9PBsLzv/vQZhx4n57clc4CNpzqIFJBZiiZm1b1LB6d3xWPyzpaZ
	 tthHQDH5TUBUsualya4DwhIbhDzadEjTBW38pwEVn7lN+Q911DIKlRPg/vwe89hOi0uIW
	 UTXsIYzw2bG34L+VAV8C04J1AxD4z3g6yFbKhcKIxnvAtFQN45mwYKWpyeiVNJsu0qQfK
	 NBngR9RJy56IHG7tTaxEpw/WrIKvZB8AtjQP5qEW4UFzHJfgHJ9x1CmVTprD0yrc+btIu
	 DOvFDKoXqECYQzyR0S5OIGhd4z7s0CfGFYjoQV+HM/F9Hi/HL/JmvbOvK81tprSnd4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401582;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=vGEtUxmPfWXs5kzpWoyAjKWpKMI2aG/Tzcbt0zDR5ms=;
	b=VzQr4mTC8vORyHP2X+4zgBFBWIHS1XO4M1m9AvNzHWB7u3wEyld8F5jTJjoVv46qrL90
	 oCgZAX3ld+2HBVW0LXNM/sIqLRHR5bm5n4ENKzLwQ28I6fpR9CgGHmt8oAXCpP8BluBT0
	 uTUMcGIWov7m/0jUmSgX1QMNa1piMIoG7iIP5bQQdBvXCHP0qCqTxcG/C9E30UB6506RL
	 6GM1BVbouKy3ZNwxVLHD7iC9EpKChGTHKk46UjcXsY2LJ23u7llfJafBdRh72k0Yjbr3v
	 hBRsMH3tq+CvBUVx+vS4i2GZ8fq3pir45wDzjqrO5LEFKRsrwvfhI7O71PdvEzeQYvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVWD5noJ;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=efesC9GN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96F606A31A;
	Mon, 23 Nov 2026 02:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D96F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVWD5noJ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=efesC9GN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795401582; x=1826937582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vGEtUxmPfWXs5kzpWoyAjKWpKMI2aG/Tzcbt0zDR5ms=;
  b=cVWD5noJyRfVpNGjNrqQkfTKKShh2oDhPfJoyXbhxkVzOil0Qj7DIP2h
   aEqlLC1Q7zPeYV51f6TmrEEftVNSFYIbGFs5D3A9f13V4HuRvtz0jwIjO
   gMp3uV5Kkn3syKJgJB6GLZWwnb2ImoIAVJsBFQPzg96jcXA1ETVgYAtk9
   REXVXa5dWh0QMZDYAwt1KB1yxZ/gTL+zqtLf4JNOW7WeE9xCwmHwptCnc
   iuT1G0g6M3of+ye/VeCY4o35FA3tDigAkngayGwm7S0tjJHZXiqp4wqFM
   7iy8LBJTQyiOtGA3z+3AQdnSMMFDX1E1VnzS+S3ANKkcskLk8aGdQZl9V
   A==;
X-CSE-ConnectionGUID: R2aQZK2HTZqiZQsX8566Tw==
X-CSE-MsgGUID: nZgh80g7S1CJ/Oulzy0EXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4244338"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4244338"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 18:39:41 -0800
X-CSE-ConnectionGUID: z7zJ7TY9STyzPeudIEbr7g==
X-CSE-MsgGUID: 2YKcHRkrTIqVy0NLvnii6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11089675"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 18:39:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 18:39:40 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 22 Nov 2026 18:39:40 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 18:39:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAMwnTVVtUC6itCrIDCTe4qiXP1yfn6j3tf+eoIGl3NwuLWDTbAat42R0ukdTp4YBK9tDnJvlFPxmEdejLx7JrUGqOzwl8EjUk4viwh2hcci0pa6rTTedbJ0+1CqRwfhOC1TRGv/9W+cAr2TMVbqkWf8/mHBT3+WLDXQ1cO01WGKDdBPP7FTucAoTe95wk2P6A7pCgUsRKSzb/hcKszX1r1F7FGY2XvMBGKcr8g7Cf/QHjuH5vvKxiEYRBy5UjhYN614Pf67FTMvyvsJS99cn5ns00TRcsuikWpWYS/cnbclrwEZcs7iUFzxCDVzFZd2o7N8UhUkiQGJNq4vH8skqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGEtUxmPfWXs5kzpWoyAjKWpKMI2aG/Tzcbt0zDR5ms=;
 b=ZK5U7qZtQVErFJtsaGypRs0EJ4bLNuV+mnv/Z9JXYGTC4hfOCRSyPwJG9rsTznMB3UlK6hfn386pd5XDWSgoKAoHWo8E8t79Y1YHvh5SMwCsPTyEvF319XyjdsJP8zM70S6U4PU16bt7tRyzFL+9knw5CDApoAc5GqC1HOux0G6FMZRd3njz2Qh8spAgwnMVRGFOreAVgYTsb8ULTzHctNV0ZpbjLEPlJZIZorRGz1BqZdKjlax9KU2NMvGSOIIFtBpgntk7dDxKtxwp7J4q+niHVsuW1rAJsTJHdNNo1/+pNdQlkDrAE8hv6wRBJACTh/iyvKY9BhQKuMuAi+WumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGEtUxmPfWXs5kzpWoyAjKWpKMI2aG/Tzcbt0zDR5ms=;
 b=efesC9GN1umk1/sqz0Cvkk4rMU0Ay5rcOHCRTEfxIvRArLppTV9Ln3mzfEbSMU952N5EtIefWKALN05GGgApR9vQ+l4el7Z0YBbJ0L10bR5jA0cDweYg+3VcW5paUXuvp9MkDOvhahwba6T1kG52Q89HXgZnA2we1RE5pm1TNsE=
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by PH7PR11MB7147.namprd11.prod.outlook.com (2603:10b6:510:1ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 02:39:35 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:39:35 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zheng Shuhao
	<viennaoffh@gmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: "jikos@kernel.org" <jikos@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "bentiss@kernel.org" <bentiss@kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>, "lee@kernel.org" <lee@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ayaanmirzabaig85@gmail.com" <ayaanmirzabaig85@gmail.com>,
	"syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com"
	<syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com>
Subject: RE: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child
 iteration
Thread-Topic: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child
 iteration
Thread-Index: AQHdeQGJVHPYy6V4fUeNP1rrrT8zvLc69S2A
Date: Mon, 23 Nov 2026 02:39:35 +0000
Message-ID: <SJ0PR11MB561395B8C8BF1B839137926793452@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
	 <20261120135005.566-1-viennaoffh@gmail.com>
 <573f3eb75601c17d6e766fc47a7cce1bc2274998.camel@linux.intel.com>
In-Reply-To: <573f3eb75601c17d6e766fc47a7cce1bc2274998.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|PH7PR11MB7147:EE_
x-ms-office365-filtering-correlation-id: b84b0c6f-2f4c-4f88-790a-08df490b031d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|18002099003|22082099003|261009223027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261028144727099003|4143699003|56012099006|10067099003|261102123227099003|38070700021|11063799006;
x-microsoft-antispam-message-info: XPhIAxQk0OoIOqkf03gFrhA4/DqmbU+d+k3r1jgX5VNqTz9L49hIJCTd2JGkGO50hAw8rezDjuFE91LnXTecu7Y9VwALnDMJ5vPcK8JXrZDgD+Eh7h2WeQFr7u11OW81jpFjXL8HzACSONoWWR9B/pQn/Et0xUoiPh2ju5NjVDdFfB/UPns5sFejR93M7JRLArNdU+TYk17Xq9afgU4bseAntJT4L1pPyJ0DbrF0XpBK5xwdP7GJzg4OFDgFRILUfqGTMxNPRmBrEozeJIIE26BG3EU2Db/SvZvkoSYB6h2QWsOEhSgv+jkpjajq74G1TgyKrsGv1c3SKVjSvtvf6ZDj/M7fiBk5Da2ghhDkCuYJhKbruA+OqHHy6NZqh0tlgaNHo5ziBcog/lFwgX/MY0v2qJlJ+EY4z7uibqoaqYX6MdVJTebFAGJDboPBULNyoeg7aH3aT1N9e9vfSYc4mubf/ofSaMGvfnSbjgCeSD38hWaGF/V/pKTPmyzCGMRj4JbDK9m7v8fGQRH/GfBiVy0y+PSGNWItSFk1VNUEzxXa5RFOe+u9jkMo3pF3zopTDc1QfTc7Z25M9pqITj33X1wJoEtRqC1sX+VKUZUf+UGXQ+Jbgh5zrwIgCCVI3twi802qjSOq//0fKQIikQyJxa/tpuShZuXwnnhZDsFYSLGVks44jWfurjwLen4tDtqvVRPSvZzR9gKYjrBQgklkzVJEKFoOvlECY9fbRyrdb1g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261028144727099003)(4143699003)(56012099006)(10067099003)(261102123227099003)(38070700021)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzBhV1hhNnFnQy9xQkZoM05VS0dTa0d4TThUVkNDdnk3blBHaEVLSXl4L3d4?=
 =?utf-8?B?OFZKbFJYdThuTU5NNTZCWTBoeENGVWRiRlNPTjZYZkhkU1Z5WS9yS0VoTHJx?=
 =?utf-8?B?ZVpaTEhDOG9LdUNPbUJhcTlXWXBJU1BFNjZ6MVNPTzdHa0lZZ093YldXeFhO?=
 =?utf-8?B?UEI4bitRTGhIWnRvRVdnWGtJRnRqNjBnVVYyUmlkSzltWWM2U09OSDNMY2R0?=
 =?utf-8?B?MFhIMnYvS1d5UFgvY2MxY3Rhd1g3a0xqZHRjemhCYUdHenIyWUk5MDRiSHhO?=
 =?utf-8?B?WHFVM3JMdk5LRnJtNGdnNjdzcGVqVUFOa2JldGdpQ1VSL216Sll5eDkvVE1l?=
 =?utf-8?B?NlAzU2V6TEdDZitXRmt6R0pCOHF5eTFoZXB4MFVIcGtHcmVFaitiNXc1cS94?=
 =?utf-8?B?Y2YvQ2N1d3VxbE1ORUpiRHlMeDBuaTVGSWtxZUhleWJNWm40R3o1WGFFbTZO?=
 =?utf-8?B?N05McVNmNXZhNFp0ZGd2b1NaV3lBWlgvVEExWnBkaWhNM1J4SXFheWxpQ2gy?=
 =?utf-8?B?YTdlWGRRYmVVUUN6RTUxWFVIV2tjQzNCcnVBYmVJVE1OQVRmYkFHQ3V3ZTBX?=
 =?utf-8?B?ZmZPZUVGRk5Xdm1Jb01sVDlpYlNSYWtOL24wZFNxZy9LUThBdUVqSTl3a292?=
 =?utf-8?B?T3ZwMmxPcTRlVDBhbmtVYUY1T3N4WllGM3JYMXJpa2lDMno4QnF6cVlwczZT?=
 =?utf-8?B?SXJwTC9DSXkrSUNFWjh5THd1dUdDalp4cE1rVGxSMG93QkNPM3B2TXoydjNH?=
 =?utf-8?B?WmhOZmF5SU1GSEd4eUxEbmwvb1hyR0htR1JRNE1HZjFzZHJWbmpnRmkxL3pJ?=
 =?utf-8?B?Ym0vUlA4d2wxSHlHaXA2bUh1QmQ0aEdkUVhrc3gyYS9hZlVYcHdybjB1ZnhH?=
 =?utf-8?B?OWM0YU1FaXFKMDhXU3pJTG55TSsxY3YrWmFXMEhESFM2TUlXOVc4c21KRDVu?=
 =?utf-8?B?aEFCTjFzeUNCN1RDTzg2SUU0STV3NlRaQ1orV2FEVldCVWFWZEZYbHVrcEJ0?=
 =?utf-8?B?akc0Qi9vcWkxRnZYS1FoenBWQWIzZlhDMUxYMG02N05KMU0xemw1WkFVbW1K?=
 =?utf-8?B?K1RrZkF0b0ovMk9uQ2wrYXJmNzc4OGk1Tk5uMmFlcUNaV1Rnc2NldHpFMXNh?=
 =?utf-8?B?eFZTc0E0U0U2Zjl3a2FJY0dUOEdCSHh4M1N6K3pCK0tabVRZbmpMblR6QzBY?=
 =?utf-8?B?dnFjZEJwZkFZK0V3NGRaMXY3ZjZFRi8xb3Y2ekNuZHVvVHo4K05MTk03QURU?=
 =?utf-8?B?NnROaVRvNm15VlZXbzdJNERkSmtQaWJSbnNtLzBydGRuZHAwdzVpRmhseDBR?=
 =?utf-8?B?TGdRRU55SnB6UnhZTS9wSjBSVEQyOVBKWHVSQ2pvak5GTHV3aytjSkFITU85?=
 =?utf-8?B?NGhqT2JqNjhyVnVBT05XRWdXMTFwd0JlTDRBZ1l4WEE0QUJYYjhCM2ExU2xM?=
 =?utf-8?B?OGxLYkJ3ejQzQ3Q0YWRjODJzazVnS2FRUjdZVkY4cW9lU2NSdXFUZngvTkFZ?=
 =?utf-8?B?cGtra0ZxcWlhM2FhVjRpQmJndHlrUisyNlRTSjJEMDYrNHdQRzF5N1BHdnp5?=
 =?utf-8?B?a3BPalFPeUdjZGE1MWVJYlNSQWl3ek9JdWFWZWtGSUFSdm9KOWpET3U1dXV5?=
 =?utf-8?B?S2ZIdEY3WklKNEFyb2ZleFBXam9EOHlZLzN5RDltS1ZSU0hEOHpmNjJXN1Fh?=
 =?utf-8?B?Qis5bUNtTHNPSnlYOTJ6eXpGVFVIYTRabVd3T25BclVGTzlQVDUzU0hGZm4x?=
 =?utf-8?B?UDVrY2lvNk8veHc5UmVmU2t1WTVYMG5YZ2hRcEVoS0xidFFsUFEwdXpBUWhQ?=
 =?utf-8?B?d2dobWliRjBCR0pvU050SHljeDZTcjIyNGdwaUVxQlNsbEtUK244bVBMQmV4?=
 =?utf-8?B?OG13NmMyL3BXZUkyUVk3VmlvajdnNVM4UWJTUFd4NWxIbVpBS2pVRGpSbHRo?=
 =?utf-8?B?Yk1ZbVZEUXhHL0RhaEhtN1FqNFNSREZpd2FhNThTUFFtK1F5Y1IxKy9jQW1t?=
 =?utf-8?B?ZWs3YlBvU2FqYTRnSmljU0JFZFNLNWxZbXkwYzhhd0JkTnhFWkNXaStUaFRn?=
 =?utf-8?B?aWMwd3c2OGFad0lnWTB3TEgxMVpBUUhpeEptQzRacmZKbm8vN3UrNysxVHAw?=
 =?utf-8?B?UmdiU0pwMlNHYktiWFZ0NTF0Y2ZCRDlzTERad0NIOFd5dmMvZmJydFFWbWl6?=
 =?utf-8?B?TUlGQ2tpNDh5a3RRUElhVHhLbGxDV0hCdWNTNGVYck5SU3BVNlRRbVJFdlFr?=
 =?utf-8?B?U1FoWFBqR3JMZE9JWGJNbGcxVURmdDBKcjRTSi9tZHlFY0d3bTZYYVJVYkRy?=
 =?utf-8?Q?vUtdUPU4l3Sx3Or1Yx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bq21Px2kkM8VqgHwd3trfjPx1M4V8jv165JKdimOH2Ti7A9xGWnRwtP3M0GwldddBpq/hiUtzF12x3WS0styDJ2xXkXCBrCoGaDQHEzyACafhTAGmwPmq6gEf0EpcbmkoMHh4uH6gAzVO2HJP2MzFniTt/RpMlyEPtJcUd2nDktqT5kH0e2nxkX98xrTALWQg50J4P6EWCqzuKhn6OdQ9DI4GUSzk7O/ENnQnIjsYRkTmJ+Y8BIGCN6jwW/YwysojMsf2h60AbaVxYgFmTJ5TtX37ke02nEqaLriqKjTM5dBf/0I6aq436+sQdQaaKO5VtT+CuWFNqSy3uGqkkwyVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84b0c6f-2f4c-4f88-790a-08df490b031d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:39:35.4524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8rk3L7/KZc0N8svzSayWOCm4tl7X6dQszIOpwGe08mDhUlf8jOc8NPo5j1ZTGrBvW+tk1Kz6jJxGnUdhYxX2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7147
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogRnJpZGF5LCBOb3Zl
bWJlciAyMCwgMjAyNiAxMToxMiBQTQ0KPlRvOiBaaGVuZyBTaHVoYW8gPHZpZW5uYW9mZmhAZ21h
aWwuY29tPjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOw0KPlpoYW5nLCBMaXh1IDxsaXh1
LnpoYW5nQGludGVsLmNvbT4NCj5DYzogamlrb3NAa2VybmVsLm9yZzsgamljMjNAa2VybmVsLm9y
ZzsgYmVudGlzc0BrZXJuZWwub3JnOyBoZWlrb0BzbnRlY2guZGU7DQo+bGVlQGtlcm5lbC5vcmc7
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+YXlhYW5taXJ6YWJhaWc4NUBnbWFpbC5jb207DQo+c3l6Ym90K2ZiOTUxOTcwYTMzNGFhZmYw
MGJhQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyXSBI
SUQ6IHNlbnNvci1odWI6IEF2b2lkIGhvbGRpbmcgc3BpbmxvY2sgYWNyb3NzIGNoaWxkDQo+aXRl
cmF0aW9uDQo+DQo+K0xpeHUNCj4NCj5PbiBGcmksIDIwMjYtMTEtMjAgYXQgMjE6NTAgKzA4MDAs
IFpoZW5nIFNodWhhbyB3cm90ZToNCj4+IHNlbnNvcl9odWJfcmVtb3ZlKCkgaG9sZHMgc2Vuc29y
X2RhdGEtPmxvY2sgd2hpbGUgd2Fsa2luZyB0aGUgSElEDQo+PiBkZXZpY2UncyBjaGlsZHJlbiB3
aXRoIGRldmljZV9mb3JfZWFjaF9jaGlsZCgpLiBUaGUgY2hpbGQgaXRlcmF0aW9uDQo+PiB0YWtl
cyB0aGUgZGV2aWNlIGNvcmUncyBrbGlzdCBsb2NrLCB3aGlsZSBzZW5zb3JfaHViX3Jhd19ldmVu
dCgpIHRha2VzDQo+PiBzZW5zb3JfZGF0YS0+bG9jayB3aXRoIGludGVycnVwdHMgZGlzYWJsZWQu
IFRoaXMgY3JlYXRlcyBhIGxvY2stb3JkZXINCj4+IGludmVyc2lvbi4NCj4+DQo+PiBQYXNzIHNl
bnNvcl9kYXRhIHRvIHRoZSBjYWxsYmFjayBhbmQgdGFrZSB0aGUgbG9jayBvbmx5IHdoaWxlDQo+
PiBleGFtaW5pbmcgcGVuZGluZy5zdGF0dXMgYW5kIGNvbXBsZXRpbmcgcGVuZGluZy5yZWFkeS4N
Cj4+DQo+PiBUaGUgY2FsbGJhY2sgYWxzbyB2aXNpdHMgbm9uLVNlbnNvciBIdWIgY2hpbGRyZW4u
IFdoZW4gSElEIGJhdHRlcnkNCj4+IHN0cmVuZ3RoIHN1cHBvcnQgaXMgZW5hYmxlZCwgdGhlIEhJ
RCBpbnB1dCBsYXllciBtYXkgcmVnaXN0ZXIgYQ0KPj4gcG93ZXItc3VwcGx5IGNoaWxkIHdpdGhv
dXQgcGxhdGZvcm1fZGF0YS4gU2tpcCBjaGlsZHJlbiB3aXRob3V0IFNlbnNvcg0KPj4gSHViIGRh
dGEgYmVmb3JlIGRlcmVmZXJlbmNpbmcgaXQuDQo+Pg0KPj4gVGVzdGluZzoNCj4+IC0gV2l0aCBD
T05GSUdfSElEX0JBVFRFUllfU1RSRU5HVEg9eSwgcmFuIGEgVUhJRCBTZW5zb3IgSHViL0pveXN0
aWNrDQo+PiBkZXZpY2UNCj4+IMKgIGV4cG9zaW5nIEJhdHRlcnkgU3RyZW5ndGggdGhyb3VnaCAx
NSBjcmVhdGUvZGVzdHJveSBjeWNsZXMgYWNyb3NzDQo+PiB0aHJlZQ0KPj4gwqAgUUVNVSBib290
cy4gVGhlIHBvd2VyLXN1cHBseSBjaGlsZCB3YXMgZm91bmQgZWFjaCB0aW1lOyBubyBPb3BzLA0K
Pj4gQlVHLCBvcg0KPj4gwqAgS0FTQU4gcmVwb3J0IG9jY3VycmVkLg0KPj4gLSBJbiB0aGUgc2Ft
ZSBjb25maWd1cmF0aW9uLCBoaWRfYnBmIHBhc3NlZCA0NSB0ZXN0cyB3aXRoIDEgc2tpcCwNCj4+
IGhpZHJhdw0KPj4gwqAgcGFzc2VkIDI3IHRlc3RzLCBhbmQgaGlkLWNvcmUsIGhpZC1hcHBsZSwg
aGlkLWdhbWVwYWQsIGhpZC1pdGUsDQo+PiDCoCBoaWQta2V5Ym9hcmQsIGFuZCBoaWQtbW91c2Ug
cGFzc2VkLg0KPj4gLSBUaGUgZnVsbCBISUQgc3VpdGUgd2FzIG5vdCBjb21wbGV0ZWQ7IGl0IHN0
b3BwZWQgZHVyaW5nIGhpZC0NCj4+IG11bHRpdG91Y2guDQo+PiAtIFRoZSAjc3l6IHRlc3QgcmVx
dWVzdCB3YXMgcmVqZWN0ZWQgYmVjYXVzZSBzeXpib3QncyBhdXRvbWF0ZWQgcGF0Y2gNCj4+IMKg
IHRlc3RpbmcgaXMgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUuDQo+DQo+Tm9uZSBvZiB0aGUgYWJv
dmUgdGVzdGVkIGRldmljZXMgYXJlIEhJRCBTRU5TT1IgSFVCIHJlbGF0ZWQsIHNvIG5lZWQgc29t
ZQ0KPnRlc3RzLg0KPkhpIExpeHUsDQo+DQo+UGxlYXNlIGdpdmUgYSB0cnkuDQoNCkhpIFNodWhh
bywNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guIFRoaXMgdjIgZG9lcyBub3QgYXBwbHkgY2xlYW5s
eSBvbiB0b3Agb2YNCmhpZC9mb3ItbmV4dCBkdWUgdG8gY29tbWl0IDQxY2IzMDc2YTIyMSAoIkhJ
RDogc2Vuc29yLWh1YjogUmVtb3ZlDQpjbGllbnRzIGJlZm9yZSBzdG9wcGluZyBoYXJkd2FyZSIp
Lg0KDQpDb3VsZCB5b3UgcGxlYXNlIHJlYmFzZSBpdCBvbiB0b3Agb2YgaGlkL2Zvci1uZXh0IGFu
ZCByZXNlbmQgYXMgdjM/DQpJJ2QgYmUgaGFwcHkgdG8gdGVzdCB2MyBhbmQgcHJvdmlkZSBhIFRl
c3RlZC1ieSB0YWcuDQoNClRoYW5rcywNCkxpeHUNCg0KPlRoYW5rcywNCj5TcmluaXZhcw0K
