Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2734BA5B;
	Thu, 23 Apr 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934151; cv=fail; b=E1u35TIPiR5B6Mzrz0SXUQUrBPEeO/5a5/uk3dAubh9tB6ZMVV76Hz6bnUQ9EwVcRXjPSCPzQZfHa8U5ffoRADDymiYCf9rfUKoY7M0Bz6jxliGADm2sn7pUSV80ieWqmwGIA34Ywygdw53YEdyTHrSIHbjk7FUAWGY5tH9HJr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934151; c=relaxed/simple;
	bh=E1IKl15En5DYvAnNAjpbEO9AxbegN2RDwxbc3/LLxrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F0FfHsPt+nvrr2kEtT7lJbVEcl6mCuXOcbZnaKTEMBIUrjq+XSsEW+VCIZ7/wd/vA4Cr4aXQ0Gkw5ePhnHxXEK7jgraTBVUwhykFN/j3PqeTAhzSF2CqkNbgizkpcwq13PvJYa6RV7Opm/+LvS1KDoRueQ1WGEb1uyNFLSlHzyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqm7HQX2; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqm7HQX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776934149; x=1808470149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E1IKl15En5DYvAnNAjpbEO9AxbegN2RDwxbc3/LLxrE=;
  b=nqm7HQX2kt6OB/CaMddxNycibbejiIbc7OnDiYioauMYwW+qxVVq0u1c
   19qkvdOx7iVZK+0DaeEPcd1V1fqkKnx3RSpoah03SUuWVL5YslqJWrxdm
   uTsz8DildP49l1BTYsUKvIyPY7/eaQk1KVppp+xO3pVuUgsw5GH8tTnjA
   pwlUz1QasVKT1tf13dZVZSYotKDzrxry+/gBXGmHb7VXA8W1G7RIm1miL
   89JBEkfrfx6ox8Z80JK3MzK92kvC/9nJdYVQYf9uSbk9u+KcOkTj/u7KN
   WfGuNrucW2hODuMMj8nVJ6Pl8e0suZr1COCwF+qFMOMkn3AO7U6rApo2B
   Q==;
X-CSE-ConnectionGUID: M/PnPE5gQpWhNNYRtzXANg==
X-CSE-MsgGUID: XEpUBypLR2KMEPDtc3MpMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88506628"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="88506628"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 01:49:08 -0700
X-CSE-ConnectionGUID: D3Dd/QAWScihwgC9jo0iUA==
X-CSE-MsgGUID: KMpIxNnjTGaczQqKy93aIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="270720467"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 01:49:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 01:49:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 01:49:06 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.63)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 01:49:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJUdQjva7Yu74i7LYirKO9a1CSj5JSYdwLtypQxOLIVdwnGvJ3I6Ljr8bxge18xmYsCaLvFzFDSa+Y4S1EUggteqtVPF8wd7ezcieSvSwAx6dMYRORzK4YxmrLDEsUOrTv+CMgm+YZQTprjwEEYSxkA7JL5/GoVJ9rCaxRV9aQucq6otPhmKbnBUHSweF9WZYvf3byFoNHMe1a0jsIc8MNU7qPI3ztqAR4/C3AdDk6tQ15P28FbUUwZalrZRJVs8E1iYr/HzNmG+lB+QCtbeZY+A8ETSyMS34SZPddx34dzxWXs6kbP6AlCigEt1zQ2zgavKIb91vWtSzI/b9cfHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBR9zbwtrE9JRjofg7+7Dj5FqQ0IfYOy0Lfl8/VpFwE=;
 b=Q0vWQ6tWkuCJ/ABRmsM29828UOCG081Rw0gvgGJLuTwRvr1mBnyPp0+cjKg0MqJqmgKfWG4mnxT4eUfFFGUYCWMDkp4bE6B86Alt9UPF+/NublWIx0HJdnz+3M/hqTZLdiqgeVjHvN1VJwzD6j8KJEHfz+QpMxOMCZVtfQ5wIdKm2JxevMjQkFKVIlxv3vvlxPYvNp2pbX4ek0qYyE8Z1vY6+jgy3cZiCli/bk3Um3KjkZ0jO/FSpwRmj7zCA/bPn4GEYnEDQikDD9IfNxUGikqLwBqQUMxMeLPiJ+djqRbT7eHyaKNIikxs2O0IHfqZn3whj5UeCiVqDzUnNiuwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 08:48:59 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 08:48:59 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
	"natalia.andre@ime.usp.br" <natalia.andre@ime.usp.br>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "andy@kernel.org"
	<andy@kernel.org>, "bentiss@kernel.org" <bentiss@kernel.org>, "Lechner,
 David" <dlechner@baylibre.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"jikos@kernel.org" <jikos@kernel.org>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>
Subject: RE: [PATCH v2 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
Thread-Topic: [PATCH v2 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
Thread-Index: AQHc0vZqDQ0J1Ape/UGPXdZFwL3g3LXsVJXA
Date: Thu, 23 Apr 2026 08:48:59 +0000
Message-ID: <SJ0PR11MB5613F611426BE08F274A7277932A2@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-2-natalia.andre@ime.usp.br>
 <20260423032038.233475-1-lixu.zhang@intel.com>
 <aenQNrLHqGxbiipb@ashevche-desk.local>
In-Reply-To: <aenQNrLHqGxbiipb@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|CY5PR11MB6533:EE_
x-ms-office365-filtering-correlation-id: 86435a3b-9647-49f6-84c1-08dea1152992
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Y8G85Iuws+XbAQ0xiVeRqYkqyDGrGiizhx7YhgZ9xml5dN0cJJdloifezQQ6fCL8WPXsxwsoeS7UfFwMOrz9Ddbc6RyeNFgTTdepJq01gFU0rIGG9dDRKen12PiCmJt2m7TA3GYkLgKwnQ9yNWfy7WNyr6D3us/V1Nhg5giO8i3zBIAY6gFWqE/SGeFbtzbJ3bUbTpUO5GzUGsDKqPC9v4nFlR/Ia2QgK1vBiYR64jdX54GGEFUfUY27awr1lzSYzSPOjgN7kGiHqzXlZWV3zUmvkn00NCRXwj9NLvC6PYuZErPrN8DjYO2W+LEk6lj9SIejsGDvVbCuvST5RzUbUq4bKFJkM/utgog6gD+WGCgPW8J42zgggNtNDV7hSHAU+mC8Lxo+Zs5Dxdzni5L5jUf25T6pDkcc8MOR0CeUyaGRanfuFLXnykcjp1JVXS7xYUOVF9sGq/GSy5tHXP8w6ri06JcC3Ve7CGN+DrsFF81Qp/vqD4iO5WTsvt2xnsC2CnRO1GeFuXf6oppKoNjujmivE6GXB6QojQZiE4Q48LgIeuswYB7dHShoRas6HM5lIYD+SROvz6UMzmzvqZ9bht1GTcKUGNKSpxGAncgbAU0UyWUu/oQZPyoCj39w3xjlEVch0F3maNxTLaDgRzlmQx5brqBLbBaAgA24b7MPDKDWfxbEucMFkTRebIWutraMN1t/35YBMILyJB5rOzHCgbXSOjej//ECjLsOnJ25VhN6DBdiUH9hquob59jVlyoLtiuEaJlE8QryXc45teRbhhlWoq8AFmaynnu8KX7hLUg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LSubxj/FfKK5n94bkKjfCBfzFKCtbRmWtEKd4mNzhgWAOexd19GBwS7z+G?=
 =?iso-8859-1?Q?TVFzEgT35sc6fled58IXKtSKvkqC3eDPMJANOXcX17XDnQm1NgIDCqkOMa?=
 =?iso-8859-1?Q?izvMrrZGZ/lcoo5ew5W0XlehfN6pTnsN/rywo0QgQ9AnAxHUM8TQihWVUY?=
 =?iso-8859-1?Q?4lf3JTODQ5ru/c8tAnlB5WbjUTfd8DhynKHxYuxfhJKMMNN9B4XF+HNx1U?=
 =?iso-8859-1?Q?yNngGHfOFASEljSaTk6hXZFznwl/IB+FCJrUfCSjd+CRTF2QzYgF87Dp/v?=
 =?iso-8859-1?Q?oOnBgNNZMGXrjbvoBeZ9BASd8p6f7rTUlsRWoGxdItTrzt7Uqne/+rY7+a?=
 =?iso-8859-1?Q?1wflRxNVMglq/HxuNM1tJWfzSJFsCp3NfI08phRXL/z4VsLc7CGwT4pn0w?=
 =?iso-8859-1?Q?/Jm/0NZ/qqouU1Phpb8pfBJAa6X4pEe+WfKFFUUqVpFTVUPYPBqkkmnDCE?=
 =?iso-8859-1?Q?cgMRxuI46xnNNhv/+v9YqPhmjp/7E8gexb/k/h/ezjOKUZweklKDqvi9s3?=
 =?iso-8859-1?Q?we8/OaGAGGCoMkJqvsLCGadHf81rNn5q+FDvx/YVRBoIM7F5h8zUmVCgmE?=
 =?iso-8859-1?Q?LyqM3WoGxi4kupzm9pVO9TPDjtgGntyw20f1xd5i2pqKnhB7eIOY6b367V?=
 =?iso-8859-1?Q?RP+edg4eSorsI2MFQH+Ym/q7PZOC5yiOmN13uSoKdGCz/89k0MIWjwNG7S?=
 =?iso-8859-1?Q?shA0mSx0+SA5ov5JkxjX0z5eqvKusyjhCS1LDQxizFfgDUvsQ5iLSd9yu+?=
 =?iso-8859-1?Q?Cx7oArA9LZ4BV5ePEbUdRcDFXLmQTtadVQfkSmMflQJhATnVGXe7TyKyqA?=
 =?iso-8859-1?Q?tJN+DfT0Hphk9mtCTpjIeleVoRLBx1/myMoqyb9EItH/5ZE5EO6iUe0dBx?=
 =?iso-8859-1?Q?3p0WDvsMr3HgPzxW59uwooYiApPwCcRSXhWEcw6o+Vt1sYRpCfAIFk7bBz?=
 =?iso-8859-1?Q?8kqfxRFgCoaBnZgMsKr+yrdxEGDYW1B/3fxZ0zXGdQ1PHsXZ7whYUq6JRE?=
 =?iso-8859-1?Q?9kCy8FV5HZ+zeUZYI9mkKKyx0byEam+PXgWM3ApwG/q4KdiT50tkiQonVG?=
 =?iso-8859-1?Q?WUI9lwxqq1LPb+6GIyIhV2ycdY+l1Zv2xVYhPDcwe88joUBqdXQm5fCsoi?=
 =?iso-8859-1?Q?hvJEs/cQDl9HDwErzkODw/eXXBpNe4LyQqUsG9MGgcZsFIhcJOSvid3jUn?=
 =?iso-8859-1?Q?H2T+Gw2ipGZVwgTTD2YFX/mBdnb3h6ghz5xKasH5XhlQaq2Y49NijkaS5r?=
 =?iso-8859-1?Q?DeH6AdHJdZ+yIR/XPQtm+pAf8WjleOxl4ELrRjy3U7geCCkPY7d+t2LZme?=
 =?iso-8859-1?Q?l31swfUiWQUAy9MmjhB4MP+XFlpySpUyfh6olOxam2K7qGU8/+Haf750S2?=
 =?iso-8859-1?Q?IfRGwiB8jaM0sshIiPuN5/kAAgb2xOTSG43/NWH5qZ1dqzy5AsDmQwSvsk?=
 =?iso-8859-1?Q?bhbSDGtAzvVDxBgDa3PIc/Cm9AFnWyJBHvLtjtlWk/qzN5rRLLOdnpU0ZI?=
 =?iso-8859-1?Q?2HO0FQvBcwL/4TdCOt/vKJDhaLOr3npqtYiYOhsv1XsqsDsrR43fycrn6p?=
 =?iso-8859-1?Q?yvCAJfpU3JJwFcDOlAIOu8Sez9pHR/gUCswkN8wKZ5P4ixMS1My4o6QhCD?=
 =?iso-8859-1?Q?DEkX7yR+M9T5IVc6goj/GQtRAbt8s5If1e0O79Ic0EEVxUUVVLmzA+hV+6?=
 =?iso-8859-1?Q?cZmhTIsr+yAbYbCBOT1K3m/ijhB50qfNMA9DYyfpzDfX9iJmNwcsw2VOGQ?=
 =?iso-8859-1?Q?VA6DPJ6mB5LlZxRpmfpDIASOOEDkGlbGiNXUkn7IcBSsl7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DcEnU1ImemDRDpTS+Ke8VPVEM9FQKsfLxtRFivBaSfcbwarXNeq0lXkzgLru5x8edplMu1anb64UapYkJpVoe+aRxcqf4rnNjFCfrcHPGxusjiwhZ1/F6flg/abTBF4YySZJAxxCc6TM/x0InvHEATpwgR/JADyWt2Wh4GZpNRyxzbZHRGvnnqvqpBUwqGtJg86QyfN1wrwq5yfrQUetJKQ2PYqNm28x6x1R7ZzyTDVhn62stxNESEcPOrudOlQNMOf01hC/VLocxQszmf1pRwilXj2dedRq6tx2YoO9L2IyvCmEA2sZpjleXn2Tw8CVua5bYmerdGwjEoZM1FOHsA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86435a3b-9647-49f6-84c1-08dea1152992
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 08:48:59.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BsdnqCQe7XKEs8a/dUFXXTxXl6VhO5cN3dAD0phanDfhlz7UjaB1GHHcfjQxSNslJkzcYMYBhKrQXlcJisILMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Shevchenko, Andriy <andriy.shevchenko@intel.com>
>Sent: Thursday, April 23, 2026 3:55 PM
>To: Zhang, Lixu <lixu.zhang@intel.com>
>Cc: natalia.andre@ime.usp.br; linux-input@vger.kernel.org; linux-
>iio@vger.kernel.org; andy@kernel.org; bentiss@kernel.org; Lechner, David
><dlechner@baylibre.com>; jic23@kernel.org; jikos@kernel.org;
>nuno.sa@analog.com; srinivas.pandruvada@linux.intel.com
>Subject: Re: [PATCH v2 1/7] iio: HID: Add helper method
>hid_sensor_adjust_channel_bit_mask()
>
>On Thu, Apr 23, 2026 at 11:20:38AM +0800, Zhang Lixu wrote:
>> On Tue, Apr 21, 2026 at 07:20:33PM -0300, Nat=E1lia Salvino Andr=E9 wrot=
e:
>> > Add helper method to deduplicate code in HID sensors.
>
>...
>
>> > +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec
>*channels,
>> > +					int channel, int size)
>> > +{
>> > +	channels[channel].scan_type.format =3D 's';
>>
>> There is no 'format' field in struct iio_scan_type. This should be:
>>         channels[channel].scan_type.sign =3D 's';
>
>Your information is outdated, I believe.

You are right. I checked commit 3253477893b2 ("iio: Replace 'sign' field
with union in struct iio_scan_type") in the IIO testing branch, which
deprecates the 'sign' field and introduces 'format' as its replacement.

My apologies for the incorrect review comment.

Thanks,
Lixu

>
>> > +	/* Real storage bits will change based on the report desc. */
>> > +	channels[channel].scan_type.realbits =3D size * BITS_PER_BYTE;
>> > +	/* Maximum size of a sample to capture is u32 */
>> > +	channels[channel].scan_type.storagebits =3D sizeof(u32) *
>> > +BITS_PER_BYTE; }
>
>With Best Regards,
>Andy Shevchenko
>

