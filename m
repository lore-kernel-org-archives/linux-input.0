Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5332D46CE;
	Tue, 19 May 2026 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168162; cv=fail; b=r0fWq2xNhXIk0vfFem9sptDB6SblfUcfFIQr3/Cbazp57F9/caCoHOIXuxufPpPGvWb1kouhzXRfeFBXE2w3rEeJZvwxRBn2gJgRzxSBVz5U4FQh1aU+r0S5Plln20gLo6Lb/3xE0UfKYqSGdVLNasxs0O+w8MTJVERw6Ff05X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168162; c=relaxed/simple;
	bh=+srNRg9eQbKuaai6hsDyezw7e+82bbzbAQUi1kAHt3w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EDiAGnCVs4Hp/RMTvl5aDs6XbsY67fD0MhG8Qt5xv96Z0JPmISiyy0JdS49EPcnRI+Ar8kSEjmxpS5+lKt1ampJ7qG57v9WM1408GR7xy84ALwrFZQtpJ/oOANGBjtV/BDn136WcJX86Dpo1I8tGa1cqF5wpRRnJIkngjcJzO1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVsuHCSq; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVsuHCSq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779168161; x=1810704161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+srNRg9eQbKuaai6hsDyezw7e+82bbzbAQUi1kAHt3w=;
  b=JVsuHCSq3KPoHpuhtVhHO/xiqrWspjcS4+2fJs52wQ88wd10CLB6asU+
   kpl4a7VUsH66qXCafi2vWNCddY8KXKoLb3ixA23xMEYyJ0IgLzo2tGiDu
   IcNQ9Lpmpd+4Pr+DYiFmrEMPR1jBTHqP4gjQKAEcySWhs/VdCCP1010+0
   h32uM98b4/7xMEcOXmN3uDdsqYylXQLWJ9k/E8bfJI0TzpQwPvNUY/zPF
   1mQ2EBKGIrTLhCWMGXBNwyoX9u03qi1bpfHwlWXr2kbXRK61KorpSc0Ps
   i5Fb1+IgRilev98YS47OExsN+TNxaZT1HLsZadZo2BKRS9FSSEKuqs6/R
   g==;
X-CSE-ConnectionGUID: A2n2Hkt6RhqJ4sH13iBUEg==
X-CSE-MsgGUID: f6EIEM41SIay1u1bph/3Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97603959"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97603959"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 22:22:40 -0700
X-CSE-ConnectionGUID: TlHrIilCTiaogygNEWIZ9w==
X-CSE-MsgGUID: ceN92VlHTH2a1qqIYEF2oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="243637654"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 22:22:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 22:22:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 22:22:39 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 22:22:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guFcBgG6e7Q4hM7bdaLwJII/3exc3PaOq/+aPkowQMq6jGJaWsiMmx9mDARWu7HdK1xMdXlxsS+brYiBhNr5lGBL4bFdmBHdOsVf0VxoxU6ajWX6oIpFNzogn6ZPNRO/e5t14lDIVYBioS0QtRMZl5FQFjkoR6FaHi4c8quNjpgxtF6WFR0tAPN5VnEqhSr5twPy8oS1lq3WSP6O2QniMwhALyHV50wFXRWvU7ajsjONT+KhDSqqrw0zlVt6Vez1xxAjlIlRm8lIO6n+0zvYst9IXioPfYVvAwqxaQEEloPhqPC7qe9o7iVpcQbz/+5q1BBQSt1isCMEP4FyART1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P210ZnmA94+IgDjwwWndHANt2AVfVUyCNqKIl9hLpAM=;
 b=g7pEKlk+pRH111A5RueUPNuDV5LpSMtuSMZymWZjD5lue6M+Yq+VCM4xQMhB307CIbHG17v0ysRb3nH3YPsixP9p4FQDaJsCEuwu8xw6PeP/s5HG7KmKyOrD11g2+buTQtQrLv0xEIEyfyauAbHy6Av5Td8SvnsLBG+PJczhL2TORf1jXNZPSs4TwkxECFmVxyWSH4DXgCJT/o0m/DnA6YQpKwIwQlV/VS6D8AMLHTeK8774fL8cXauxhCWg10gDY3dcPBnZg+a12IGlPHvS6/X9gvF54RXBxgptTSQVftzDt6l68zEDTFGqlmywm3sEUdvya3r0A7K+T/mRawCBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by DM6PR11MB4594.namprd11.prod.outlook.com (2603:10b6:5:2a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 05:22:33 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 05:22:33 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
CC: "jikos@kernel.org" <jikos@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Lechner, David"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
 cleanup
Thread-Topic: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
 cleanup
Thread-Index: AQHc35wsrw3sHMeT8kKWXH7AkG49XLYM2M3AgAXdAoCAAiOBAA==
Date: Tue, 19 May 2026 05:22:33 +0000
Message-ID: <SJ0PR11MB56137045FBD6900E96F1CDB293002@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <SJ0PR11MB5613D4ECB8081985C3F2D82293072@SJ0PR11MB5613.namprd11.prod.outlook.com>
 <agoi55wCo//eY1YQ@hu-ckantibh-hyd.qualcomm.com>
In-Reply-To: <agoi55wCo//eY1YQ@hu-ckantibh-hyd.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|DM6PR11MB4594:EE_
x-ms-office365-filtering-correlation-id: 652e1e68-1031-4669-eee1-08deb566a167
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021|4143699003|11063799003;
x-microsoft-antispam-message-info: 75yZMZP6yCYR8zbT3XDldABSQXfdixr5Lwf5gALVeoM4bq2mN86bZQmmCr22qLymEQob5h2G5wcIgdr4/krqwLMmdiJW9lhuPW0gSA5qnljvk9bIJ8fBS2yCl38FacAIcgvID8ssxGUsEzpGCEkJIyQvwLB4ev7VEFOLNfzUAZSZkbWsiPxNUmjsCOIyhouW8LJ9lqlYT1DquzXX8Yf9mikWjqQ7WBQmNT+NvL8HUP4nGIcr9acTyF7MYLiRhiNfHm6/ARSJWx79oEE1j6+RttZ+m7T8wg6sn3jkQkLX+kUix98HCNS5ZFYms8LYFfRj2xKJJRyBwOoehPYqJFeGgNViZ0JZp2yyY8bVpu0HqVnyDjpyN9dWBkbuBa84OREEE67laNJgwHHvoTMubohDkVKBw+6ZRVxRZ88TJEyWeYNDjmFnnEbdiHIcy/TXW4Q7qgvuyecfmy8xEz6Ieva9MUgvkD7OupwZc2IvLR7yoYLnhje1r9zkOCtNEvywlJ1Dv//jHmTniddK/kUUKTnrxmppXcfADoL75UE5xCkTCOtm7DwSG+D75bK+Jgi/KiROqRBpSdBq8WMWbYNSK9NDKeC9MeKrWM1TN2Pry7VCXYizjS+u6D8/R0+221+VD60ZXt3za3NStkATjjOQzNNAUP4ixYhBEBJjCHH8nddVsEAwfUahqKq2h1LUj59Rq5PDJKHCw8trsk+iQ7/eZuXbDEX8EYu7cgrUQHaTkCSlrC2bHUT0fKUek5jgbkANzKxG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AeYtqk17hjlENjBNbukK7oxPAXESK62QUVl6fnipDl6PUGhgBNYgkHqk8gJq?=
 =?us-ascii?Q?yH12msfPxvNMpbLc3KoV1iYh/lsiyOSJASGynGoYOEIcezJh/5NF/vvhjF+3?=
 =?us-ascii?Q?3qVLNib9YjpiPtDFUEE+vGiKU8nLp6UJjtfxn9U5OTAv25qgc/RI1CQJq6ve?=
 =?us-ascii?Q?XgIJORn1v134wV8FciC4YnBXXv21v456k1vtPGEbSLYYR5EkGRucwwTtVdKi?=
 =?us-ascii?Q?Y9DAYpNBhcBbG3HOdU9F81LAZNMBhZDIZRGxaQJYPZ9U+al/PjMNM4HnHF7G?=
 =?us-ascii?Q?XHMCNGQR39reqC5RpaM3EqwRi0ejPwIMM87CvNmp2kEbmPWz8MJbgoYxQiDd?=
 =?us-ascii?Q?5sxkP1/igiiDyqp9mF7h0gzvjFV5r0XC3TbCrZbHEkEbuK5l3iL5J57PrGqn?=
 =?us-ascii?Q?0sjy/kV53/bhgupGsK+MgmF8YP2zxqAptJ6acdaZnAm6NJorzHTczJM32zJ9?=
 =?us-ascii?Q?fQtBfNVNRL89EW3+JRL2neBcG5LE2w/a1evChYaxZaPVCUUZcR8p83gnnxaj?=
 =?us-ascii?Q?oZNSRnBh6BNAsyvnuMDRs5yXSDaJMkEu6TpMFIcqJyXtVNJbWahTiVQy6JET?=
 =?us-ascii?Q?fUVUbGTrDvTdATIEYuq+/mLGwgLRK+PKvnHkbJd4vmu0tnNHl7UpF7KGLjWF?=
 =?us-ascii?Q?oU1GpxK0divjg1A3K1mM31CUYH5DEhytpG0FsToABxZ/gGdvDY+UbXEYHo4I?=
 =?us-ascii?Q?rkL9XszSHEj+nSEXu9PhyT5gwjx0AOiEHK2/Nkr+al2AbAEcdC84sInLY+92?=
 =?us-ascii?Q?IQ+DqPc0GA3edtYNcACW3QdJ6DrOknXzC2PBSf0MPIHOzPRnOGzxygzSE60H?=
 =?us-ascii?Q?UrVd92yepsBRTrISFgJkb3A0iIVYwep9ZpLXxNAO9ZKHU/psNUoepLWdDZG+?=
 =?us-ascii?Q?FMfhT8nbOIvR3BSN1ZE6+zofF/p6A/oxQNqVBRYk+IQZ9Q0Lmcr0wMregyvn?=
 =?us-ascii?Q?vYw/X3rHlB2fPP1+O/7G92ABYUJqNSnAW1aQ+xY2CQGZii+qKKwTyetXclMZ?=
 =?us-ascii?Q?qxHfjkn7SzacJltaRaGRoC8pmtnqSfL2hw/MzmMWT79yBVGNzWvtKqCa74S5?=
 =?us-ascii?Q?5uMJMC2Wu4OrnG59ANPVnkFH8YDmhNgijO6+xcPwYhRkuSWN4Pl/1ZBMtkKo?=
 =?us-ascii?Q?wxlvCEhtJw8nmWiFdWaVUNoR6pU2a1p9fM4VSfg6iU2fHINiptXOnkf905M5?=
 =?us-ascii?Q?1aP+ELxsg5EqN4QK/TvBJttb4EYrco4z8CpLyQHsaxAIY7vDgKRbCD8Hixm+?=
 =?us-ascii?Q?M9zc+UGQOH6i8blgloaPnqd28v/rssI4gELLZ97t3KCH6Op7Yl5UQxG/xG/U?=
 =?us-ascii?Q?3DN0TeNZvXPSZY3nGmz7kN8sa/hEfoltO3WTCyh7mQFDpeqKhOn/OmdiFrh2?=
 =?us-ascii?Q?RnUq5Gj74B8IlDxUio7HptnOYxLp7Xm9iALyH0o8eUF258IxF2B+nacqBHWG?=
 =?us-ascii?Q?zeltS2+0gEKLtAeNSIQ7NjP4mntn17+5bW1FxMAV/lSm7cIkdBl3mZbQSh6I?=
 =?us-ascii?Q?/nPBtEb+bbgQh8XDhaUam0ch1H6si/RDL2wjOdHhBtz5FxFHD7Yl68S9VvD7?=
 =?us-ascii?Q?ecXR68U8W6E1PM6YOG+lLGgtA5Wax1FUTMHZAikDpwE1j0sIyhnKolnm6Yw1?=
 =?us-ascii?Q?uu8UznFn92D2DWjUWprBJwUfwYs8fKY30fYd1BXC9pCLEaokttJJFUM95ByG?=
 =?us-ascii?Q?3APNAN/AeJEPb8dGL4A+UHQarWRRNIRDjz8jY3dbO9F7kp46Z436SAu1AhIl?=
 =?us-ascii?Q?gr1HKOwVAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W2H6fzBKkji87qvyegysF5qf9t3ZCHWhgBGGVqjxcFBOO9BvJPN4Aq/2/NLQi3SmBZAnAlhubIQh6NLWu3XjnqTQ04lzCDgRfpdv7aUElEcGaezbOg8XK9x7VN+ZyYzmOtpQzDFZeK23MQJycH+lMY7Kd/tZr5kq4jfFAb5xINBZz3XaVeUaevoI4gZmzyj+DNk3ANwXmlsTkvFHluB6hrfHhvCH0s6/Hz6lGk6+BMNKIQ6elqlgkeNfKRNz0dgLmbGFmCaVzliwrmQPeHgt1/f/UFTYgtOLX7y8Dtr30Kqlh8FjVEMrMObTWCQKCpT3GpnQix9ql8wCGld7HxyGZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652e1e68-1031-4669-eee1-08deb566a167
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 05:22:33.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixrhOboNIVW5N0KqBy9RGJXJhrMXurtG9f2oM7nOmXrdAK3+mR77Rj5tDUHgBYGY1FVq/aK76yGw8+rim14+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>Sent: Monday, May 18, 2026 4:20 AM
>To: Zhang, Lixu <lixu.zhang@intel.com>
>Cc: jikos@kernel.org; jic23@kernel.org; srinivas.pandruvada@linux.intel.co=
m;
>Lechner, David <dlechner@baylibre.com>; nuno.sa@analog.com;
>andy@kernel.org; sakari.ailus@linux.intel.com; linux-input@vger.kernel.org=
;
>linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup =
and
>cleanup
>
>On Thu, May 14, 2026 at 02:47:52AM +0000, Zhang, Lixu wrote:
>> Tested-by: Zhang Lixu <lixu.zhang@intel.com>
>
>Hi Zhang,
>
>Thanks for the testing and validaiton.
>I hope you validated the complete series, including the unbind flow for th=
e
>drivers using devm API.

Hi Sanjay,

Yes, I validated the complete series. The unbind flow was tested as Sriniva=
s previously
suggested - performing the unbind while iio-sensor-proxy has an open sessio=
n. No
regression issues were observed.

Since iio-sensor-proxy does not typically open a gyro session, I applied th=
e same changes
from hid-sensor-gyro-3d to hid-sensor-accel-3d and tested the unbind flow o=
n that driver
as well. Again, no regression issues were found.

Thanks,
Lixu

>
>Hi Jonathan,
>
>How should we take this series forward? should I extend the series to cove=
r
>remaining HID IIO drivers for this devm API, or this series can applied to=
 IIO tree
>first and sent followup patches on top of that?
>
>Thanks, Sanjay
>
>>
>> >-----Original Message-----
>> >From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>> >Sent: Saturday, May 9, 2026 6:11 PM
>> >To: jikos@kernel.org; jic23@kernel.org;
>> >srinivas.pandruvada@linux.intel.com
>> >Cc: Lechner, David <dlechner@baylibre.com>; nuno.sa@analog.com;
>> >andy@kernel.org; sanjayembeddedse@gmail.com;
>> >sakari.ailus@linux.intel.com; linux-input@vger.kernel.org; linux-
>> >iio@vger.kernel.org; linux-kernel@vger.kernel.org
>> >Subject: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup
>> >and cleanup
>> >
>> >From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>> >
>> >Key highlights:
>> >- Prepare change as pre-requisite for devm conversion for HID IIO
>> >  drivers by removing redundant argument
>> >- Add devm API to setup trigger and clenaup resource using
>> >  devm_add_action_or_reset()
>> >- few cleanup and prepratory changes before updating driver for devm_
>> >- few sample driver update using devm conversion to auto release
>> >resource
>> >
>> >changes in v3:
>> >- Added cleanup and prepratory changes before adding devm_ API
>> >  conversion based on self review: 0002, 0004, 0006, 0007 and 0008
>> >- Address andy's review comment on commit message and coding style
>> >- v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-
>> >sanjayembedded@gmail.com/
>> >changes in v2:
>> >- Following input from Jonathan and Andy, squash initial patch v1
>> >  series in single change as individual change should not break
>> >anything
>> >- Add devm API support and two driver using the same
>> >- v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-
>> >sanjayembedded@gmail.com/
>> >
>> >Testing:
>> >  - Compiled with W=3D1
>> >  - Build-tested on QEMU x86_64
>> >
>> >Based on further feedback and reviews, I would extend this series to
>> >convert all HID IIO driver to use devm_* API.
>> >
>> >Thanks,
>> >Sanjay Chitroda
>> >
>> >
>> >Sanjay Chitroda (9):
>> >  iio: hid-sensors: drop redundant iio_dev argument
>> >  iio: hid-sensors: cleanup codestyle warning
>> >  iio: hid-sensors: introduce device managed API
>> >  iio: gyro: hid-sensor-gyro-3d: cleanup codestyle warning
>> >  iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using
>> >    devm API
>> >  iio: humidity: hid-sensor-humidity: cleanup codestyle check
>> >  iio: humidity: hid-sensor-humidity: use common device for devres
>> >  iio: humidity: hid-sensor-humidity: use local struct device
>> >  iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger()
>> >    using devm API
>> >
>> > drivers/iio/accel/hid-sensor-accel-3d.c       |  4 +-
>> > .../common/hid-sensors/hid-sensor-trigger.c   | 24 +++++++-
>> > .../common/hid-sensors/hid-sensor-trigger.h   |  5 +-
>> > drivers/iio/gyro/hid-sensor-gyro-3d.c         | 16 ++---
>> > drivers/iio/humidity/hid-sensor-humidity.c    | 61 +++++++++----------
>> > drivers/iio/light/hid-sensor-als.c            |  4 +-
>> > drivers/iio/light/hid-sensor-prox.c           |  4 +-
>> > drivers/iio/magnetometer/hid-sensor-magn-3d.c |  4 +-
>> >drivers/iio/orientation/hid-sensor-incl-3d.c  |  4 +-
>> >drivers/iio/orientation/hid- sensor-rotation.c |  4 +-  .../position/hi=
d-sensor-
>custom-intel-hinge.c  |  4 +-
>> > drivers/iio/pressure/hid-sensor-press.c       |  4 +-
>> > .../iio/temperature/hid-sensor-temperature.c  |  4 +-
>> > 13 files changed, 78 insertions(+), 64 deletions(-)
>> >
>> >
>> >base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
>> >--
>> >2.34.1
>> >
>>
