Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D338398F;
	Wed, 17 Jun 2026 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781675358; cv=fail; b=b99Mh24Wl0KZFaGbjl03mMrSbqKWaA0i4jKOrMUBnlz/AXhc3hB4jiaE5dmnMBCYduukqduhpadLNnOT3+dK+VxF5IYcSnLPpM0OB/zO/bWobYpe0wlMexD/MnAemJ/0qM7CmQjb/peC5IlFNAyUb6AdcP/+qy+qqx/JzKqnZdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781675358; c=relaxed/simple;
	bh=ivPe2Is7J9dncqXN1VR0ZcH2UBch0xW6W+yHys+5iSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tPFXUEycWLF4PmBeC67EyZ5hC/TKEJevSL31OKt+0a+9xlohUN5xhXf6EZ9dhHrtx2wBad92JmhP2GZoBKJDXqYSIQVya3Dzb3AAyw1I2b0D9HnNkxXj4KvTQy+hb00d0ACEUpjho1bEB/H/FEQYnW5VPYbnpbIC6eDfkQD0VqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHJewsId; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHJewsId"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781675357; x=1813211357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ivPe2Is7J9dncqXN1VR0ZcH2UBch0xW6W+yHys+5iSQ=;
  b=XHJewsIdPK+z57Cid57HTwby+ZY1j/2oSR8e0wxfFJpMycUFvJSijE0G
   5iiwcU/VPJ9g2qTsdx8ZSweJsF82XJaJFNnF4ZC3pG/Ysxn1tuMy8+1+V
   cbR06X2LIq8bRnhDnQ6Law/UvtkH/ThzzKgykVG6X/TLJbeA8n9Twuvlr
   rm2pCeshCjFFofX8QKT7VqIDqCtbEl9FrAmwOT/Ky56a0yGQXyclQlOfy
   aKu0rowcmMOBfNUq6/Etv+RQZ4JluDa2/Or+lT11hyhkdWeKR29pXdjRi
   myMoE32nWMJH+LQYA1WeoK7oAjfSt4XQZVLn+Id9rHDlc9GVmqlfgbCX1
   w==;
X-CSE-ConnectionGUID: vcHL3GoOTaC6bSX+ukomYQ==
X-CSE-MsgGUID: nyHajn9/TXua7YaAkZQZcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93027360"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93027360"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 22:49:16 -0700
X-CSE-ConnectionGUID: 9VbEHRwkS8qB6AZx8DWAjg==
X-CSE-MsgGUID: BW9bQ8yhQgel23BFfZpNEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="271688396"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 22:49:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 22:49:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 22:49:15 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.60)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 22:49:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2AU5XKq4CYjy9uKSJpHHQZBIe2fOCpb3Cq33km5Ms0lxSVrS9mtLJZgPw2xt8f1MWYnzvAs0skdozEdsGoBuKXpOds0LrxNSHgEH/PZWoop0LMm/98nmdydmFpLgFLX7pbKLWoGwBnufx7rMsTNtOzbqxd7EBDbDeOJXlrsybAdQZVwmUl6ODv0N/i1SNGpF91RghHhZ/TwDr1X3EOTwu75I8oeNnHyLdoQRBKGxoOsLVXpUKVSQDpiBJyTBXHh2H/j+1jsrSY+I6S4nssQ5f1vveILQagqhAKvatzJO8kHMSAgy4T04cwuBevf/0fpSHV9IDtjYnu/b7+jQ013Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvCRblGfr31FY4f9GBBjEmvcJKZ+dwBPZzoZ0GmPThI=;
 b=G9378Bif0q9so5SIlGA6B03oVA9COzQ4bOvi7wIMfrBCgCbOzviIbzSsK1crQ0GDxc19Af/GOnw/crZCfDkOTr6aXw71II1YNrqA7u0Q2ayC+5hXPcHrJlDaFOYpk4gqTN986736SqWwLhd6lOaAngceGBKCOGFgZjcxxRRTKed90z67DA3CetGp09oYd7yjAHo04VCd+Mc7vYxyEjSt2IkqtoPxfiVWEt9Imq/4AwTzcRRtdZv6eGx3Wx2d4HE6+bSvEuGtf1fY/FHFpxHnIpIlVLQkCFWhhSdfRtJSRasC8u9Oe0EiyywpK5jrYxyIN5vdNTI/nIu3ks+xNlVZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6448.namprd11.prod.outlook.com (2603:10b6:8:c3::21) by
 BY1PR11MB7981.namprd11.prod.outlook.com (2603:10b6:a03:52f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 05:49:07 +0000
Received: from DS0PR11MB6448.namprd11.prod.outlook.com
 ([fe80::2346:c494:79d:931]) by DS0PR11MB6448.namprd11.prod.outlook.com
 ([fe80::2346:c494:79d:931%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 05:49:07 +0000
From: "Wang, Jie" <jie.wang@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Henk Vergonet <Henk.Vergonet@gmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com"
	<syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [PATCH] Input: yealink - stop URB resubmission on completion
 error
Thread-Topic: [PATCH] Input: yealink - stop URB resubmission on completion
 error
Thread-Index: AQHc/cTAwPX2yx/2lk6b7soYo9KqZ7ZCNmeA
Date: Wed, 17 Jun 2026 05:49:07 +0000
Message-ID: <DS0PR11MB64484A4A38381336F2AC0C3F98E42@DS0PR11MB6448.namprd11.prod.outlook.com>
References: <68bba4fb.050a0220.192772.01a4.GAE@google.com>
 <20260616110440.1073059-1-jie.wang@intel.com> <ajGfjuo3MTlezkYX@google.com>
In-Reply-To: <ajGfjuo3MTlezkYX@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6448:EE_|BY1PR11MB7981:EE_
x-ms-office365-filtering-correlation-id: 2a560b34-13c3-4501-4544-08decc342588
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|22082099003|18002099003|56012099006|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: V71e95j589JAMj3CR0QiS/WTHDiMHOlb/R0YxSFg/Qx7v9SykW78c2egRHWOIgP2g7K03v156cSsEsILDQj69HtVUj+qw9jGu9vxXnu/5M7TlQiISWwocEIZeTb0Wte77WYHnMZkfBN6OA1tbDbMOCuwkiArXhEqNCVZynnBr6GwLsiSJnI//oM47qoKu50AQbAdgsdQTLYepYK0p56q5KNR+veHMZJpAopN60zkKtYRXyLILCIPgxYJprtqfbWePQigaC7Q4om6SKNcjbKvmppQ4QMA8gqTHhNy1EjOlRUlO6EStleR96hvY10qYZqlJ7ltQfmxBVKt+gpeJj3LX4GfsOYafAF+SL/oxH5cAT8AeA8Rm+tZDoGvi1uymPQhSJlECUPG7h5X/hJq+bmXmcFgoSXCXRtii3F4OJKHhY6iA5AmfeNeBcWnkM2fKNS1M425yYAB3ziEg8RSTuKPgZIMJAOAwLYZXKWweDNB5kffRkscpZ06CMtGfFX+kPJHNlB0XRo894OFTCBtEpKOev1B2soIW56GPTEKQBAlUNxDPlr2bp55+kzuUHdefwmDaxtCPXshN/cJqBgKvab81eTrN/hcGMfIPlJ5/3cjB2hhTBVzRzvw244X3LGIOLLZfzz0Azuwf4CyRhjOSIDWwvpSpDrZgbg3Ng553UeUpYRFac8R7T0htH+yiFLwdjdIge6K0WgAGJfmuLYUUylrYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cSJRUs5xam/xZBD8FeHCd5h41BVRe7l9YvSEysNAHjaincaPSkUuj/17lVgO?=
 =?us-ascii?Q?4ubcaAO1lRDwEs1PtRMmBj/g3L+w4AcAK1UPnseHgKGH7FAoxUpuPnmVW6dX?=
 =?us-ascii?Q?nhD8H2KI3TRKqA/w9kam42jzBcJA7oWNCk0dgXPQOvfjbhx5+dz+9QtqEaCG?=
 =?us-ascii?Q?15o++zL+BLo1bzHNyTd/5dBavbPPWeJuQDIkAUI52dKeI9xYi9ae+JAHnJpd?=
 =?us-ascii?Q?/om/jG2/NeJCWl/1wCc0RA/YZu9NrbCwXCyxLpUZko9PwmJAdUB0sjtZsDVh?=
 =?us-ascii?Q?D42Nk59bUMc/QTr09lMkwb8DNM/MTyfhp3sA9AUHc8mCcauUzZF9sOduvP/2?=
 =?us-ascii?Q?WZ6MnYC1LUxHupgwNfqDRyGEo6NLTnuyfhPr8vTpYa2DAybxgSQykrLoR64W?=
 =?us-ascii?Q?Hq3m3MNeH9dsS5/gsclEm6ZpBDhaSnZ9QoZUlRrqs+srQvM7OhUttGNLF9Y1?=
 =?us-ascii?Q?UOQF94Y7Q5P48jciXo/dcIkT7Od0dZS7gzmWbQuC8Y7DZP4eda5aNOMd54UH?=
 =?us-ascii?Q?GIjZq0JrapIK8pAOEDPI5DjqLF5x/HPVudT4FUOBg6G2gozSyoJSXYZP+r5+?=
 =?us-ascii?Q?WxGYUTU2QQHb06MdHVCEqImvvOpQgwFyB5TYzLXJm6oxd0meHCcgWmhb2rnf?=
 =?us-ascii?Q?GyA+cPES0v226aP0y0aPJZu+gCSs0gomfrhDy66jA6vBk9kqHD21YfrLtj35?=
 =?us-ascii?Q?+6ZQsutNNsMpQGp5lOGUG5NTwUfs5RbrD+Wk8MfEQZH+20oORzuNISSTeBLL?=
 =?us-ascii?Q?Wvo9uwInYRYstmsOZ+hC85bQlFtMjD+Eu4JgPR6haQP29XzoJUGiaBy7XJa1?=
 =?us-ascii?Q?RDI9lIf2YqxROJyIp2Jii58kLPx+UZWBXE5uOZ3NPB/nh0/6J55HMoTg1FEm?=
 =?us-ascii?Q?vPopUsKJWhMFJt9bVai/OzOUD19bqQnohl0IZtUAAHQaTO47sdJFPLHtMwIy?=
 =?us-ascii?Q?kolTDcyMJRtLX1Qunnjrgqh7ykrYjCEXGOWH6jYNEa2kqYD/tr181DTCD3Jb?=
 =?us-ascii?Q?o7QZp4+sCmWwIFLpGHpORfMkFe9hRSnPtFh2EV1tJ/ZiD3zfY4qwyB8iH5gL?=
 =?us-ascii?Q?LiqWwNvNrrmeMSmKPHsK5W0mnk3hOlz1yjSZ3boqU0U2ODp8l4aib38dvxlt?=
 =?us-ascii?Q?Fmm/1Zq0/fBb1C77vQm036ZAndZKlFpFFaSezvj5CLN6FcOULNSq+gSOOU3O?=
 =?us-ascii?Q?gj5Q5zH9cdkI7Huf6BcG0TgBnreG6nRvX99zMMU4RoACXroZPdq3ifuiipSY?=
 =?us-ascii?Q?UX5vgb8b+sn0m2YdNkFkEIsqJTW9uBDMkBsG/i/8/js/+xMn3k5VoiuSQnsU?=
 =?us-ascii?Q?sV/DtzJdkUzbr/MM/GnPkiYkpxP3LBXWDEZ9XmG56JSzMHrey3d4Hn+xU+09?=
 =?us-ascii?Q?Fjhr0qtFUsolzA+0HlNmAGE6ACn+nPNcKc7Aqp+3YpKl5pUJqJK4xNLnAdQ0?=
 =?us-ascii?Q?lqXXmGSu+V1JPs8BPM+2RgDTRbc/XBBwJJ5bsIGnKJfy9bEG11hg2XzZlHB1?=
 =?us-ascii?Q?VfCkVyWbXFWC6lrTRztumAjAVShEEyajq8W8h6+i3/3ddujt/GsdYDkW9xV7?=
 =?us-ascii?Q?evonif3rXWPGP5iHDGzOjgdk39d/VWyG23VsSUHTyVUD2pHlG1YDLoHWS98v?=
 =?us-ascii?Q?XNKu4v52CEIR24CjwZKetVTmByc92U6iq7NemnJ6LUHcjYuBfOft9R4Rrr0P?=
 =?us-ascii?Q?eiWvx49yhMzjc7qmHbNfqvyp6s2eYwmvQqDdyzf6g0QTuYjQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ya2KViA8DFRsSBsDw1ccDqMJk4VbRDBvuFkHlIverZcs73WgVaRutPwB5DB2u3gQfSkpP6dACyq6T97jwGFmgPejN/mjtruDAy5yiIjnD1DI6I9QZvA3wENBdrILHex/mH/6A7Fw6KvZzCcpAdXqh+wBctN51Gb7v9XAnrKsXrXoRyjhhqrSYmQe8wVS5UBe/QaAigDUm1BMHBizyEMmRSxdq5rJ/pK1tqYhlEzcjki7nNqk4s6snar9DB7z/mBe3xY38fH+MyjmxtO62sFm/FuqWObggwIRuQeMFNn6CgBR23sKWC5Y9YWdxI5EsIHwp9cUQGdTsSG9myAd5jsk9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a560b34-13c3-4501-4544-08decc342588
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 05:49:07.3179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcnZXuW/brS+Zvin/XfmFNEbFmWKd2GciAEsZameqc3vatVe/BdLfiw4l5iV15te1/DqFb2SjIdfv4DXqpVnfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7981
X-OriginatorOrg: intel.com

Hi Dmitry,

Thank you for the review.

> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Wednesday, June 17, 2026 3:17 AM
> To: Wang, Jie <jie.wang@intel.com>
> Cc: Henk Vergonet <Henk.Vergonet@gmail.com>; linux-input@vger.kernel.org;
> linux-kernel@vger.kernel.org;
> syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com; syzkaller-
> bugs@googlegroups.com
> Subject: Re: [PATCH] Input: yealink - stop URB resubmission on completion=
 error
>=20
> Hi Jie,
>=20
> On Tue, Jun 16, 2026 at 11:04:40AM +0000, Jie Wang wrote:
> > urb_irq_callback() and urb_ctl_callback() resubmit each other's URBs
> > regardless of completion status. When the device returns a persistent
> > error (-EPROTO), this creates an unthrottled resubmission loop that
> > starves the CPU and triggers RCU stalls.
> >
> > Stop resubmitting on any non-zero URB status, following the standard
> > completion pattern used by other USB input drivers.
> >
> > Reported-by: syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D039eab266c6321a174bd
> > Signed-off-by: Jie Wang <jie.wang@intel.com>
>=20
> It would be good to have a helper like
>=20
> bool usb_is_permanent_error(struct urb *urb, struct device *dev);
>=20
> instead of having this "switch" in all the drivers. It also unclear wheth=
er we should
> not attempt to re-submit the URB on errors other than ECONNRESET, ENOENT,=
 or
> ESHUTDOWN.
>=20

For the helper - how about a local yealink_urb_check_status() in v2?
A usb_is_permanent_error() in usb.h would benefit more drivers
across the tree, but that's a larger effort best done separately.

For resubmission - I'm thinking stop immediately on -ECONNRESET,
-ENOENT, -ESHUTDOWN, and for=20
everything else retry up to 50 consecutive errors before giving up.
Counter resets on any successful completion, so transient bus glitches
recover but a dead device won't spin the CPU forever.

Let me know if that sounds reasonable and I'll send v2.

> > ---
> >  drivers/input/misc/yealink.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/input/misc/yealink.c
> > b/drivers/input/misc/yealink.c index 8786ed8b3565..bbfa1a9c23d1 100644
> > --- a/drivers/input/misc/yealink.c
> > +++ b/drivers/input/misc/yealink.c
> > @@ -414,9 +414,20 @@ static void urb_irq_callback(struct urb *urb)
> >  	struct yealink_dev *yld =3D urb->context;
> >  	int ret, status =3D urb->status;
> >
> > -	if (status)
> > +	switch (status) {
> > +	case 0:
> > +		break;
> > +	case -ECONNRESET:
> > +	case -ENOENT:
> > +	case -ESHUTDOWN:
> > +		dev_dbg(&yld->intf->dev, "%s - urb shutting down with
> status %d\n",
> > +			__func__, status);
> > +		return;
> > +	default:
> >  		dev_err(&yld->intf->dev, "%s - urb status %d\n",
> >  			__func__, status);
> > +		return;
> > +	}
> >
> >  	switch (yld->irq_data->cmd) {
> >  	case CMD_KEYPRESS:
> > @@ -452,9 +463,20 @@ static void urb_ctl_callback(struct urb *urb)
> >  	struct yealink_dev *yld =3D urb->context;
> >  	int ret =3D 0, status =3D urb->status;
> >
> > -	if (status)
> > +	switch (status) {
> > +	case 0:
> > +		break;
> > +	case -ECONNRESET:
> > +	case -ENOENT:
> > +	case -ESHUTDOWN:
> > +		dev_dbg(&yld->intf->dev, "%s - urb shutting down with
> status %d\n",
> > +			__func__, status);
> > +		return;
> > +	default:
> >  		dev_err(&yld->intf->dev, "%s - urb status %d\n",
> >  			__func__, status);
> > +		return;
> > +	}
> >
> >  	switch (yld->ctl_data->cmd) {
> >  	case CMD_KEYPRESS:
> > --
> > 2.34.1
>=20
> Thanks.
>=20
> --
> Dmitry
