Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E34204E;
	Mon,  1 Jun 2026 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284402; cv=fail; b=A1CROxCvuhNTr4TZIQ4cghcx45alHtD9xUmoYE6rOi1TNeEJzhhw+MDejL9WjqfFtCfaq9Hk++Jh3STlTnyGY8/MiOxPHK2+mZnUxnXOa6LjGP352rpMZ286jmgN3ICne3TKvtEexLIbY5iTMjo+TvtPvh6ht0IYpNiY4k8BvTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284402; c=relaxed/simple;
	bh=cirRQxiJpQtftdTvHzEgj9RV7jPfsW6Me8Ih5QUh/qU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQ2YJhXpQU/R8U8z1Z2tkvwkSZcGlTdq8UHB2mGAVLshrroua6rDObfam5DiVLXD5I690e3NOuQ/9TcvoCET4FQ2tpZkG5Baxyq6j0XLCooIghW+LgAA2RH7UofAED2gQxODkYr2C21BaS3dk9bg4+o/txemRt4jKt3d+MrrJJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSmrx/T0; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSmrx/T0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780284401; x=1811820401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cirRQxiJpQtftdTvHzEgj9RV7jPfsW6Me8Ih5QUh/qU=;
  b=nSmrx/T094np1AdBygi/qooXVAvzjkNzHNjNkkSW565Vvy8X7uU2rEmP
   BcEcf76OSykSVzflAKeUVP5LMP0Y31LcfpxJKccd6FwaShBtd2P+57Rgt
   PtBcizs/iXHN1VMjUn5Rwibw0y2i79qOCDlcOsRDbjV1BF9AhlBuHD9GJ
   uDMqX2vVs1JshOXJWLMu6tyQhBZQvIeDWfu+r7UxBH7GNyBtIbn4yvUId
   VL97B/JvG/pOip3bKfhU2Z5/D3CDIdL/pz4j7s4HP4RxAbCSR7HjgOxuG
   2YDSG3T9FZcf0eHLwReEsku/DaZuzJexSr2avFI4IfIue7qovddhaZEM6
   w==;
X-CSE-ConnectionGUID: ZQ7klILeQJyC5Ls5AcEMxw==
X-CSE-MsgGUID: ON98Ga8FQ8K5A8Pav1R8/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="83613570"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="83613570"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:26:40 -0700
X-CSE-ConnectionGUID: virWso8OTlamIkGrmya1Jw==
X-CSE-MsgGUID: DL76gf1cTQadTmZqVrUXjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="240452096"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:26:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 20:26:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 20:26:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 20:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL69GEqoF5MXqn80G2oamO8CFOyBuPx0s0LLUWdSALTSgHrWAxOPdJDQGS92bSnlmQnnB8Ul7e53ClSCIftO0J/7cE+NS+S7FqIJt0ktN+I7Cx5hnc6PzK3IM9MFJ8CJyW6A1tBsHwAXJ+YOO2RydicaG159kuGugyo5Bm0o2yq7Pd0pAzJ15x+DhUfIvhpCI+4XMu5gDPScG9oFiwrbttat0bnGpS4ffeaGUaxo9lbRNcmf/MvUaUQcy3sK9SJC4tIhboJJ0uBViT8hA6cuzF9F+ix3/oyvumuFPLgc7QiGQJSsIhZS1SfgJyzF91b7F3rCiWoiyEPZUeN/TeJ9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOiPva1ahPb1h6i2szcHa/dpPgKJtq+MI+bTroASsHM=;
 b=AeN3SNLDomvPHum9D+9FCX0wDtaDawnzxDuzEWKofO0b3q2+JLY3sQ5VHcrcR93+p17vY3vnKPk3dbfLJ/kj+ubxysk2K0LLVreA3fpFUpCLVd0jXGxA4SzvA+dqtaVumJbnDNmWukNm2uu3RrlhxmfSUlfJUQexALxlr1cEMCkf/nw21rS1JPd/d7LXjvZIkexh98h/Yq8C3WZNsocW1zE2f6a+ztKbI752IBmYlxcC08B0vMSSF7CJaj1xmnpwdvB6LQTBhNLDQqgQPaHXqw84hlDPkXcQqKrnNWnJPJ401AuN007H228uanOWArO8YKi2OSnXS6qixn6soEQ2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 03:26:38 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 03:26:37 +0000
From: "Xu, Even" <even.xu@intel.com>
To: d3z-the-dev <d3z.the.dev@gmail.com>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Abhishek
 Tamboli" <abhishektamboli9@gmail.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>
Subject: RE: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Topic: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Index: AQHc77mrUbJCsvCWBk+2B+n2qvQl/bYpBmKggAAG/eA=
Date: Mon, 1 Jun 2026 03:26:37 +0000
Message-ID: <IA1PR11MB60985B856D77963E2DBE47F9F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
 <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|DS0PR11MB8052:EE_
x-ms-office365-filtering-correlation-id: 3f74a4da-7dfa-4a3b-5436-08debf8d9701
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: r3nOh/YKmUOkfoTOW30mhU6isY709GvfCsapt7ebDHzzn0feW/tzS/hff4teXFtYbGV+IjviGP8f0Ynz2bhPzzKcbcnHd2AnEii5v4QDhCaXUeRFXtmQ4W1p2tig4igMwIfD5t2RqRAhv59VFMVS2m7RcHQU9ZiqImqbaqIfOOeaYdIqJWgb2bPxuW/h/jelDZb8rBHTCiYgiVjl8EF8aMUJLl20OqzaGsz12AVoIX5vBaMbVoDOEuMaiwKU2OKaCTsDtl7jDt2Bdf+FIu8oP6Q4rLyZyjppG0GY54fMehxOADWSmQXhZ00hehaH1QPA3s/C3SjbA4tG8B5iXXKpngHvzsHPLE+ea1dd9rurvkQn8/Jwxzt1LxKl4YzbwZLL2UGGvv7uRK5+YZcHcniTpfWzdECEreCzDlAzn6XSTGI26/++L3sLfMmUa3pHTy9CiBo/g7NadiEO0AYqQMqAthUQBzPTzVmwMmyEazVanQJFLW+BSFLGUYxLelQt3RGs4n/eN+47feppCj340yblnhLLRa2eSWNpc3ZTtZ/n9NzhMdnzVd7wZUKj1MWGP7LiyJcWwFlYYbSzIsJkJoCE1JQW2xMBfym0+OvQ/l2Uyhke70zWq7aeEp9bBSVMprwHZczWf5gZvWCVbvifA5FzhPnx+srjjXElS8MchTtTqGNKvICRniEydXmVHiBTIOOCtvDlrotnEJkI2tgNhTTiMyTZ2WtGPDs6CV+b3763ptIRHLoaFmUWJOTfD/TnoKiQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8hKXZ4mEaMvRbg/pRLZsvBD/mSER6hy3PFS17ALyEvcnyt0prQLAlHy/moEE?=
 =?us-ascii?Q?xoWLynMo9idlYuBYJvNClrGYCoaBbxlH79P4FV1MUWeybx3er8qR6NgteacP?=
 =?us-ascii?Q?mVxGJQdH0OM4bBYk23Xk4XjK0cuE0tF0sTLyJW5xpfSPGZWkbsQbTyhsyr+J?=
 =?us-ascii?Q?PloaUXYhF/vg4vcmLhWla64koFzKX2y1f4pdsRJqz0hXHftpIPNQnGSYYZXM?=
 =?us-ascii?Q?WLvteUuQlMaIiwSkGlCgfrFYgIfAjyQtW1NNRWjzf4Xo2/cGnCHQ2bGvfJyT?=
 =?us-ascii?Q?8sF8JHGItwuFP2lRYyQHoJMzpu7RyuPCNA2uXS7dQVQkDLSW9myhQhdC7F6w?=
 =?us-ascii?Q?NOoYcU7URMJx3envEhtCQqkOhazo7dO8nDGqTLWPGhCDy9iY2KjGgSRqcfGv?=
 =?us-ascii?Q?dITv9vYNZ//IXd+e/cZRRSg36QuuS7DoXh2t0Bkh9e3K6lxyvgFg1fH2zH5m?=
 =?us-ascii?Q?X4KFN+EsxeIw5l1UCD2J6XvJxvN6OR8RDwtGvoyHde96y9l1J4Qs1GoKPKFr?=
 =?us-ascii?Q?+7xpQS7Q8IV06/mw6vQFeT6n6pc5pTfM3jueN/3gyVl+3pdGlE3uOjnJFqiV?=
 =?us-ascii?Q?Af8lxct9x5+8A9O6qAyz1KM0tahyoeIpFeUVeyPv7lHhA6jyi5tdyDeNlkEK?=
 =?us-ascii?Q?OCmNTbTSM15rN5YRQEkAF9C//TEgm1PLv5MSecnPgqtK/nnVIKt/rLn5bCzW?=
 =?us-ascii?Q?rVpyZVAG90xdicfhoe+UYV8qbT2HuwBzu2uAFmhZstTPbWWEYtrBQ09eiElJ?=
 =?us-ascii?Q?Fru3BrwSo5gFOUlDvouJXkOdgdekYF+nshWeJZAPZnyCf9+1L88O++j7YrsE?=
 =?us-ascii?Q?X/BOe8uO/8Mt6Z6v8Gaf2qF5JJzWwFZGJQNMlOuye6l32B6PuSVCWTikuwJG?=
 =?us-ascii?Q?ocW8/ZsygStohFtkh0/GQcyq+3D7jMrtuBmc+Lbylla1gMYrctrHwm2DeBBC?=
 =?us-ascii?Q?1LT/u8wgJxvDMw+uGUxO3bu/OmYP0VqD7EMCrw2Wp6He2w+9Af/u3r2FXY1s?=
 =?us-ascii?Q?HF5UZNRNVJbXQq4hDOGsnjwc1jqQzA7TUfOXsDlS40+v2ICgBwEh54QWRZzQ?=
 =?us-ascii?Q?qX6v3JyEfU2iOhDv0EUdY7ySV4nPVWMoE6SuuVlXysKVrog9PkVaQFP+khXn?=
 =?us-ascii?Q?6nb78sSzyhx1BVCVyQcIWcnACBAvk+jFehIyr89ufxQ0bDsgZbkP27YM5jtK?=
 =?us-ascii?Q?aasQgu3Oj4L0Ps5E3eMtWO7BReRigKTyTnr2yEV37nQGcVa/1BU4lTHKwlKP?=
 =?us-ascii?Q?rVtUvzIpEssFWc6+j0UdWf8lJB4EpNmu6fOqyZiAjY3iuvY457QHtwRbOMwd?=
 =?us-ascii?Q?PNKLmk81fJ+M8kYSKIBEIbrFP6xV7n98M1LBb2eSKl2Iqw8LrWc8Fj3Ko7Sf?=
 =?us-ascii?Q?ISTYdb6cBE8mnL+KMaJeuxZ9mzHvnzIyGvmjDMeiRRbpa3xgoO3lg6gLPS1P?=
 =?us-ascii?Q?U9TGbhX4KMHrnvxKSXN4He3NWaVH6guADeo80XA7ejUI5Yy1Ak+HdE7u0+aK?=
 =?us-ascii?Q?dJhmwQ3SAN5Wczt3LSoIhSJJmG/nCbiwWP6EMr1+fFOIrPxZeQu/c2z+VcmJ?=
 =?us-ascii?Q?HTfI2KMhM0f3mg45ELlqeNZE6qYQRf1InW1DEUNGEZDi0XoQHnrc9XrS4vVK?=
 =?us-ascii?Q?emm5a39KhO7K1ofWnc89gT2bupDMqZvYlB5LsR9HAPKoUFg4UCTM1eT99rB6?=
 =?us-ascii?Q?N86JZszk6arv9eKjkaAE6SwF5kt2ovgeGNU9TiCtCf2dUlLM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F3kunLbnqapJlcLdSZAqLOBeQN+E5sTLBK1i/ut75r+RgFwLQsr4BhqlyqqQ7fSy7OlwTH4Ynz0iiASfYteIGNxYvVrkjdGOlkSg5ZZ7H+DugRhK1nuwyCudTN6dawizawA/xPnA3QqdHK2wlcB1guE3BT66HNZKl3UijNqGKbc5G19iNqIVZjC3RTdWHLJEvZZKu7jKIdxNgNUioCR5XOqydW78Kzx6w+C+iIyfmotnoIdX9CohniwTejIs5P4RqRqVFQiPysYOPpmgOhQYYqwBQUQy5NaM4nEOo2c+TbELkwWDzy1z2hNXyPLWsd/a6AWa5Y1MSvrr+KBqEEbK2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f74a4da-7dfa-4a3b-5436-08debf8d9701
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 03:26:37.7400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1r64ztK3I16F3+SeWFIGqcz0YM7WN29YuDG6UqJLZFT6SKiMDbUSBIiijc7t8FZt5GMGBUhlYvRfi08FrdvrRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com

Sorry, missed the doc link: https://docs.kernel.org/admin-guide/pm/sleep-st=
ates.html

> -----Original Message-----
> From: Xu, Even
> Sent: Monday, June 1, 2026 11:25 AM
> To: 'd3z-the-dev' <d3z.the.dev@gmail.com>; Sun, Xinpeng
> <Xinpeng.Sun@intel.com>; Jiri Kosina <jikos@kernel.org>; Benjamin Tissoir=
es
> <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Abhishek T=
amboli
> <abhishektamboli9@gmail.com>; Sakari Ailus <sakari.ailus@linux.intel.com>
> Subject: RE: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC o=
n system
> resume
>=20
> Hi,
>=20
> Sorry, I cannot get your exact name from this patch email.
>=20
> From your issue description, I suppose Surface Pro 10 uses "Suspend-to-RA=
M"
> instead of "Standby" or "Suspend-to-Idle" for suspend/resume.
> As this documents mentioned, driver needs to take care the suspend type t=
hen
> handle resume flow carefully.
>=20
> Actually, I had a patch for this "Suspend-to-RAM" support several months =
ago,
> please find attached file for the patch. This patch is still under our in=
ternal final
> validation.
>=20
> It will be very appreciated if you can help test attached patch on your S=
urface
> device.
> If it works, then everything is fine, I will submit this patch with your =
name after
> our final validation.
> If it doesn't work for your case, then we need to future debug on your su=
rface
> device to refine your patch to let it more standard.
>=20
> Thanks!
>=20
> Best Regards,
> Even Xu
>=20
> > -----Original Message-----
> > From: d3z-the-dev <d3z.the.dev@gmail.com>
> > Sent: Saturday, May 30, 2026 6:22 AM
> > To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng
> > <xinpeng.sun@intel.com>; Jiri Kosina <jikos@kernel.org>; Benjamin
> > Tissoires <bentiss@kernel.org>
> > Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Abhishek Tamboli <abhishektamboli9@gmail.com>; Sakari Ailus
> > <sakari.ailus@linux.intel.com>; d3z-the-dev <d3z.the.dev@gmail.com>
> > Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
> > system resume
> >
> > On the Surface Pro 10 (Meteor Lake) the touchscreen stops working
> > after a suspend/resume cycle and only recovers after a reboot. The
> > driver logs
> > "GET_DEVICE_INFO: recv failed: -11" on resume.
> >
> > The touch IC loses power during system suspend (s2idle) on this
> > platform, the same way it does across hibernation. quickspi_resume()
> > only restores the THC port, interrupts and DMA and sends a HIDSPI_ON
> > command, assuming the touch IC kept its power and state. When it has
> > actually lost power the HIDSPI_ON command is never acknowledged and
> > the descriptor read fails, leaving the touchscreen dead until the modul=
e is
> reloaded.
> >
> > quickspi_restore() already handles this for hibernation by running
> > reset_tic() and reconfiguring the THC SPI/LTR settings. Make
> > quickspi_resume() do the same: quiesce interrupts, re-select the THC
> > port, reconfigure the SPI input/output addresses and read/write
> > parameters, run
> > reset_tic() to re-enumerate the device and restore the LTR configuratio=
n.
> >
> > Tested on a Surface Pro 10 across multiple s2idle suspend/resume cycles=
.
> >
> > Link: https://github.com/linux-surface/linux-surface/issues/1799
> >
> > Signed-off-by: d3z-the-dev <d3z.the.dev@gmail.com>
> > ---
> >  .../intel-quickspi/pci-quickspi.c             | 38 +++++++++++++++++--
> >  1 file changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > index f669235f1883..d59278a3e5c1 100644
> > --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > @@ -780,24 +780,54 @@ static int quickspi_resume(struct device *device)
> >  	if (!qsdev)
> >  		return -ENODEV;
> >
> > +	ret =3D thc_interrupt_quiesce(qsdev->thc_hw, true);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret =3D thc_port_select(qsdev->thc_hw, THC_PORT_TYPE_SPI);
> >  	if (ret)
> >  		return ret;
> >
> > +	thc_spi_input_output_address_config(qsdev->thc_hw,
> > +					    qsdev->input_report_hdr_addr,
> > +					    qsdev->input_report_bdy_addr,
> > +					    qsdev->output_report_addr);
> > +
> > +	ret =3D thc_spi_read_config(qsdev->thc_hw, qsdev->spi_freq_val,
> > +				  qsdev->spi_read_io_mode,
> > +				  qsdev->spi_read_opcode,
> > +				  qsdev->spi_packet_size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D thc_spi_write_config(qsdev->thc_hw, qsdev->spi_freq_val,
> > +				   qsdev->spi_write_io_mode,
> > +				   qsdev->spi_write_opcode,
> > +				   qsdev->spi_packet_size,
> > +				   qsdev->performance_limit);
> > +	if (ret)
> > +		return ret;
> > +
> >  	thc_interrupt_config(qsdev->thc_hw);
> >
> >  	thc_interrupt_enable(qsdev->thc_hw, true);
> >
> > -	ret =3D thc_dma_configure(qsdev->thc_hw);
> > +	/* The TIC may lose power across system suspend, reset it to recover =
*/
> > +	ret =3D reset_tic(qsdev);
> >  	if (ret)
> >  		return ret;
> >
> > -	ret =3D thc_interrupt_quiesce(qsdev->thc_hw, false);
> > +	ret =3D thc_dma_configure(qsdev->thc_hw);
> >  	if (ret)
> >  		return ret;
> >
> > -	if (!device_may_wakeup(qsdev->dev))
> > -		return quickspi_set_power(qsdev, HIDSPI_ON);
> > +	thc_ltr_config(qsdev->thc_hw,
> > +		       qsdev->active_ltr_val,
> > +		       qsdev->low_power_ltr_val);
> > +
> > +	thc_change_ltr_mode(qsdev->thc_hw, THC_LTR_MODE_ACTIVE);
> > +
> > +	qsdev->state =3D QUICKSPI_ENABLED;
> >
> >  	return 0;
> >  }
> > --
> > 2.54.0

