Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795133611;
	b=LrXuAeQgp7BBPswr29/4dJO0jGR3sim6K8h7auI8xcTTL1HbgnznYLWprri4W5UQwfQV
	 j89ixKR7BPH9jZVSdTiqGexmOgR1lVx0ucA4JJyzHtbsR0t/1Q5aKv1EzGenYxuW66ngw
	 c+iIPDvmQoNkIt1bXfocwpqqdferj3E2VEAWX+FRsnyUvNjPHpwNts5ntPYzhVgXy85hM
	 qb3N1ZnIhucpnqfN/oWsbBsQ+jtryG6xFbmt3u98wxMB9G/S+fYuWE2I9rxmxJ1vc/A6J
	 +3BOey4FsTEhXfaVuyI0B809VPGMd/Fesy73bqQ/6YTJEvGigbQYEtg9el/bMsUV3vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133611;
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
	bh=cXrW7pUcf4C/T1vUhEnFwrqhyy1U9IdwrDfRQ8jEIpY=;
	b=3fr9suiePOqmekpXJqxEZQBAR/6NCLSXgR7Z5DFKxX6etUItaAl5g+X3eyNkdL9H4KFa
	 PQGvcYt1SrnJgwFF0M/r6TK9TGZJyjxlxUJoPNrORGOd+YHHCKVDh1a4pULv1TsAByma/
	 N2EArPj92lh81e6HLmgiqfltfgLDw12jMiwunl5JT3qVGP/0FOu9KOItBhJPIakKxS1L1
	 l3vKGuSYhQ5ajY6YYq8juNCu+9wH3F163q3VG2xuFZhVBBUXPKbgxnb5O05sjovDmVBRF
	 SIrA7m1I/NbWllPwqfH+8leaRm9wvHGXkfse9S5KBRsHwhT/8kSFf4SdR1ORiGQ5K+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DLkYw2Ge;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k5DpXSKx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54425606A320;
	Fri, 20 Nov 2026 00:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54425606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DLkYw2Ge;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k5DpXSKx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795133611; x=1826669611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cXrW7pUcf4C/T1vUhEnFwrqhyy1U9IdwrDfRQ8jEIpY=;
  b=DLkYw2GeL8vZCDeeWIhI3QthfJNp4g2K2weul+M0BIDPDz1O1JFl9X8t
   BsTBFhLqUfA7GkXHZL1f/FWMeVXqWi2HmIGuj4rh8ConSw6D3q0nrHGY7
   nJSZJ61GC+S3HKFESmrf3/02zIppDqryv2UMjJcwT3NMY8LszbaZPiwOF
   QYRSyooXVjFzQfnMEcfmAlMHAno8hZQL8pfHBQAVE7c8bjH9dKOt6WQEj
   Hqjl8Xysi7YllMELUdgNEHigB7SoMOV0l9Jot3SDvpHbuvxttF/kTaFbM
   z/KeyJY9hM1/lc4pTbpvvHukmEAh1+J2hpuMPST4NVouHreha28k4eiyj
   Q==;
X-CSE-ConnectionGUID: zNtsdXONRu2a2IrLBrA9DA==
X-CSE-MsgGUID: lhqQR9TzTzOIGceYEfELUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3996667"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3996667"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:13:31 -0800
X-CSE-ConnectionGUID: P+03jmaaQESZwmXcsPQP6g==
X-CSE-MsgGUID: /ibJ5XY6QgeJ01tu7ONUWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10387071"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:13:31 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 16:13:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 16:13:30 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 16:13:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIrmhBxRvianhyZbwkU3sFK11M5Uv652wIKG/1/ll4ZWWowY0TzIP6HRA5bRRVJv4Wb3DDxdKmnOxQlPMZB3AxvcF7bcd09uorsFsUKE1saQ8OVhjMJHi/M3YT94tE/C0h2zeGlAJ8x3e4dSihE1LA8am3ItPBs/DJS9WYkVYByaF1REpxXQK723orGEU8JRsCsbCTPx+52Q7mtfFmkb1FnMVdbEMk7YBtUY7CrpeJ7QS6UPW4QcugWomo6aaBvL1VHLmalsoEEN4zos6BvdUzcmiLsvyNYRe7IeIaDuTmQUUxqrKpKfHGbvRnka0d6tuQc/WnZaWfDzKMpZ4la8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXrW7pUcf4C/T1vUhEnFwrqhyy1U9IdwrDfRQ8jEIpY=;
 b=U2y3gKtk98h4sw3sFAYaU0tSyuB2D/yzArBGXaDyOIFlyE3IV2zsUWVGcgZxBOKncAJh3yDjL0J0xxILI/NQ/plVO+3NlvIvge2+UYt+UbL5AynL5YiOwM56eXiBBYMQZxtg2j44TkH1IOJssXBfbJdg6mCvZea8rZgjJRozcnkyJEjy8uvzyATX4N07a0Pcy2/PyuOMAVazOVkt3HTbicu1j+PgA135TTFjColWj7YGea5yMVFiUcDNoRS9UnYvncwEc+sNdHXuiM7UZ23pmxNe1OjaNN6Fix+MYXf8sSmW/HU5aYKKys9hSr4H7ifbRt7zh1tyzCgLgIMNWyH38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXrW7pUcf4C/T1vUhEnFwrqhyy1U9IdwrDfRQ8jEIpY=;
 b=k5DpXSKxkc9sLocF8qQh7CEtAGV1OE/8qZ6tJKIPpnMFuf3mYzgmT9ER0Ba7QCmhXHZEMp+1nygAQ9qQBHTIXJJQkJ4Qgn/f0c55lWlYr5WGAndbt4efEHvutPR+gsL//XftohbKJRj3JdUBPQvLb/w00MAJ668NQ9oP7x6IAjI=
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 00:13:27 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 00:13:25 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Jiri Kosina <jikos@kernel.org>
CC: "bentiss@kernel.org" <bentiss@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui1"
	<rui1.zhang@intel.com>
Subject: RE: [PATCH 1/4] HID: Intel-thc-hid: Intel-thc: Add safe DMA read
 interfaces
Thread-Topic: [PATCH 1/4] HID: Intel-thc-hid: Intel-thc: Add safe DMA read
 interfaces
Thread-Index: AQHddaRTABaBeIF5+USqGEkv6CAPQbc1680AgAAwvzA=
Date: Fri, 20 Nov 2026 00:13:25 +0000
Message-ID: <SJ0PR11MB77043BD9AAB06B85C2091D4BF4782@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261116082805.3986615-1-even.xu@intel.com>
 <20261116082805.3986615-2-even.xu@intel.com>
 <snqq816n-8167-q00n-65q1-69p49ro39648@xreary.bet>
In-Reply-To: <snqq816n-8167-q00n-65q1-69p49ro39648@xreary.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|PH0PR11MB7472:EE_
x-ms-office365-filtering-correlation-id: 259e9132-5204-4c6d-85a9-08df469b18a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|261102123227099003|10067099003|261026121527099003|4143699003|11063799006|56012099006|261021121427099003|261026140227099003|261028144727099003|261022105027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: ArmYgQog11SRHj356NQ4mZUxRE5QY7+B5SnQFGi0k7UpmDMPjsmT+loa05vzF5izNUqd0iWC5X/LABvuRVHRAOZ8Z9zqvJPqJwAcNv6w7FPgGTHUlcJcuVUW3jOfYZYQk+EodZkVYq1MJOedsyQHSmX/MlprQiwIVaMFn0Ya4pnad6Ybwi7WxozeUKYbnyPQYwdn/crWwTc19z5lTB6YHno6MRH3ITr+fGutST1rPY6tfGlDKtvN8IXfSbZ9TgOo/sMSm/9zq8gngiq53ctM2GdWOWeoFRnDrOkpCDG7xvSFangRy8CyeMz5ELk9QpJei7vPkLAU5VT8jtm9R4Z+6pLm6wfReLxKi5q/2msr2puEG9xklGQLLRC439MjLS13TrCMlFscgEtwyvcu2JE++ee1lGmcasQKamA9HKyP+KXJSZ/vkDjpFl27eAPzRwaS3bR8SzD972VlfwJAacz0dJruxl+giVZjp4dDVZJOt+HHKAXx62HBCKwEgXTElxwkkGP5TrEJgWPSohaHP63k+F7ovywxWxAPYCWbhhbYCldvcbo86GKNWJ7Mg2r9sr73jH3hmrjgqfZJbUams7lz2HJGgrH8Gns+11r4rtqIjqkoEf0E1mvwU41iJ4AF0nM2z71MTY7tYwD2D9djJi5uj7SWeZ+HbdgBBcQ2OnuwLV10L9yOyaP/7/6iKFrJ9khZ2hZ+iPuJKsgWaM1s22BHkkF+cYw+E4V1e1pBa/7u0l8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(261102123227099003)(10067099003)(261026121527099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261026140227099003)(261028144727099003)(261022105027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WLPiipY3FA/6/XDRF77EJB2vUm0TmvFDZ1NbA/XlMxCp0OEAwy7KC9miQ39a?=
 =?us-ascii?Q?YoyuA/Zj/XYkNrCGY6tus+SaLhav8JolRYZ7pZRUs7Hc58Bz3PFcQPB2VZDO?=
 =?us-ascii?Q?t2nUsgaPkhEL0HhTpP3E8KhcSxiSSg9MtZr+fDUZoySpbIPH3qCt4X/SdmES?=
 =?us-ascii?Q?6tcWHtpv+1nxKKdTFbJ+dtTWHQv8K+CryJyrxmS5Gsr3u+kYDfrmhf7KFKRV?=
 =?us-ascii?Q?6d0S/mauJn52qdkO0Se2Zwv1a+UhO1OvGBg6fS+CuArRXlRZkgMJDjPtkeit?=
 =?us-ascii?Q?hmQChi7V85BrrBZCQJgb6aQDXOxJmp2fGxhdEKSMdJOksaNIB6rG5aKbx8kF?=
 =?us-ascii?Q?42DnUZklvIibGNeK3qDaJH96gfcPsMWWOojr5f3KNpysfHRkFCFafUCugLgA?=
 =?us-ascii?Q?AYMDuKNU5bA7VcJrsWFQ9ZLWrYy4Ds2xmI3ubBq7IhfuXxedAJFKwkO9RJTa?=
 =?us-ascii?Q?L5v8KcrJlL47jqOdFKstsbXu+/QhbAL8zJbq3c1O1ADZXNguzA/bRY8L8cZH?=
 =?us-ascii?Q?rN7zhgRBr0TalIzyEKeOm3Qllnnu4TJMQjaoWVE8RYUtWUlyrS+gZUe2sRza?=
 =?us-ascii?Q?thbQoKlq2bAA/J+EV1M7B7c8czDRD628lX5qwyWX4Z5Ao6TWzDP8nY/CSldK?=
 =?us-ascii?Q?W2r0zSr7rU53MQbE5YxzG/KX4DhLV5vuXtwoas3w39oz1L7tZ9lHkZ20LsS1?=
 =?us-ascii?Q?6EKETm5gr66CqI6CbLSpz7KsemXVn7Dn1dvseFO8CR39i54tdf0GO0fF/ctO?=
 =?us-ascii?Q?ts1QLaGd+8APEhKu+6VYb1Fq2TTi54gH8Iz9qJAjYJLvU3Eblb0rT3+LGAIk?=
 =?us-ascii?Q?YAjiouIDhYwpnVcN5Xk/dpYIf8cfAHfRdyAOinlOVdZehfP96U2DyoQEOIwk?=
 =?us-ascii?Q?jBZTiYVHlpBVzAjRPGD/O9tDvAJB5pzU8LnbfZzp2pI1av4d8LLIBaUq5IiQ?=
 =?us-ascii?Q?kElFtLbJS5x/qJgSP6+eQGOUGI9/dD0Q2d3utZ/GnhmGxV32o2R86wF306WZ?=
 =?us-ascii?Q?IdAz+5pxfVhy+STQVGZg5K+mrox21S09XvJ0HZoeVfqkd4OmXjwNXSVcTGOV?=
 =?us-ascii?Q?ErK/LP+7xAtuhGaFWiUTZ6MImoJOhuhcEIkGtXFa6fNwLlJnaqsZyPQarHYk?=
 =?us-ascii?Q?/LW9dZOtBy3OSgaEnG9qJ/PsU4+c1Qgkgd/adxuArtqF6O5wYAMxB5HZHGZe?=
 =?us-ascii?Q?8Os1TdSf0HUJwTtUTlh2/pLP3pHSoE6ZBAlA27Gih64yyVHW5DluOGrzgN1R?=
 =?us-ascii?Q?rhHqvcsF1uvCPfdylBDOVb6ERYJE0GFxWME9rDnwTYC21jjUtRARRJ2rkIsc?=
 =?us-ascii?Q?pu21upE4swwXjpiraWym6LubakKpoJxDIt5iqvrtJOI8q7w5o5XcK4L05wFj?=
 =?us-ascii?Q?5XlP4taQtwmHbe38chE4RlobYAtPN/fnaj/ifTJxYeTHQQcfooWxb2YCnVrD?=
 =?us-ascii?Q?T80v3UCqohH5d0RWB6dRm2bKaDecuNFJAlU6Yc5jaBUiu3Oov7RTyRRGmIvD?=
 =?us-ascii?Q?o3Ij9SjNtRUuX6zKtYloqC7hcXJIEspVyA2cFedhUHsPBp5OTCwRwKSt0ANd?=
 =?us-ascii?Q?VX0LI4iVFQgVsTzIuOGwXvTcQciAUGJB1DjlIHgkjUawIqp0KJOKhk+hSY3m?=
 =?us-ascii?Q?cQmmucIg2S+S7EJxPi9dgRh3qM1IuIhAaHaozCoJ+j623su0hqPwHUgDc5B+?=
 =?us-ascii?Q?NTfVRYK6hS7C0/pIY8/K2tHUsuXDqMFbzmDIEUEibejZL0nQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s7Sgcj6JLudVERKx0U/c9nnnC5EDimHFo+obW8Ufh32sGvFLJy28/lAb6t7BwhchQl7y+g2ZM8AwFRLS0+NAZ7vgXA8cIEhfXAJa41T1S1tALxoyidZkgS3fm84BsseXbbFywg4ED/QKaBLVuu7IdsmpomRXKkX6azGhBZLN6bn2TmTeoqaNht2lgwhq7BTD9krrBQ4TExqwivtCJX2ZoIaLG4E1oUUCG2FZ0vRlyzyBzM9RSCq3LfNo/okO39zqX8Ue/k7xWfMnw8lr+HYYpcTOtFZEdvnDYaWSC0LwBwsntKM3dE7WubfjY252Qv3pUlLtR02SXi0WFjFCdLFAeg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259e9132-5204-4c6d-85a9-08df469b18a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 00:13:25.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQQKBP+n/glpSR8SshrGYlLrCp3ODWzKqwXlG0KciMcxU3D+Qx/C7i2VNKHkoYYbA4EwbNnAL+lrfMpaGriKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com

Thanks Jiri!

Best Regards,
Even Xu

> -----Original Message-----
> From: Jiri Kosina <jikos@kernel.org>
> Sent: Friday, November 20, 2026 5:19 AM
> To: Xu, Even <even.xu@intel.com>
> Cc: bentiss@kernel.org; srinivas.pandruvada@linux.intel.com; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Rui1
> <rui1.zhang@intel.com>
> Subject: Re: [PATCH 1/4] HID: Intel-thc-hid: Intel-thc: Add safe DMA read
> interfaces
>=20
> On Mon, 16 Nov 2026, Even Xu wrote:
>=20
> > THC DMA buffers are rounded up to a 4 KB boundary, but callers may
> > allocate smaller receive buffers. Checking a frame against the DMA
> > capacity alone does not protect the destination when do DMA buffer
> > copying.
> >
> > Add thc_rxdma_read_safe() and thc_swdma_read_safe() with an explicit
> > destination capacity to check both the DMA capacity and the supplied
> > size before copying.
> >
> > Keep the original interfaces as compatibility wrappers.
> >
> > Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA
> > interfaces")
> > Signed-off-by: Even Xu <even.xu@intel.com>
> > Tested-by: Rui Zhang <rui1.zhang@intel.com>
>=20
> I have applied the series, thanks.
>=20
> --
> Jiri Kosina
> SUSE Labs

