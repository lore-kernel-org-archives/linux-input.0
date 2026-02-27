Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020140.outbound.protection.outlook.com [52.101.196.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC414413253;
	Fri, 27 Feb 2026 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206092; cv=fail; b=Y4WlEuZ1fkgBJFEarawW1vpisHUPCsBWB/2Fsve/X4wfGU/k9UkMyHbWczNJ4E/5sUUXOi5oEF3z+EdWqIXmgZv36op8k2JFuznuKyfyEPMP5qadKR946F4UkezrvQeJ9WnJZJ6O2OyAFml3+AtKcgBr5ajEQ4mDT/oCdlo4FIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206092; c=relaxed/simple;
	bh=Omjiur6preJbu2QVLInCHieI9X5osYIwC+TVzCsmDnU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=lAvB+CrVQYe7Heozi16pB2LWrAQ0TEk5Z2Sk+2s+vDFcF9G3VetKcAPLvCZDMmS2/eSoccq36Xu/dBejvfc+krKajOkOTUlaMq6DVMsa5Nix7kP5H1ENxUStyt91gVluqydhNqb2+COvtAG59GuBifOXmrzR85wolN2UOQiNOJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=qGODKUeh; arc=fail smtp.client-ip=52.101.196.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="qGODKUeh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gA4HWH5ioH/gXc5vF7lm6x585tMo/lyEXvKXHTaag4W5mFa/mR7omC2EGluc8cp1JioYNzEpfLaFyq6o3UcanIqWXoGZHrsNMOiW8Tn2BtYlEkdnQcEWqmfrnBdsxyMvh6fzKHjUQn7ZgV2p5cjsTpLgYM0Bql5v8QyH9p8xfq5sn3EWpYiX+afWpoH7JyoF36DIoThnrOjZIJMqMDmEunXFaZ6FhhZXRR1YDPRC0Q1pWdTsvewF7DEtghzCy14qqwiU1/IzXhAYciTxLNhPWpluUZPG4DtV6CFL0BtHstSTfquVM9zDFX4269PNSl/ix5OnML6YWvarwGV4xBegfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2EygqyGuTHu0SObEAePsjWfhGiLtN+WUy9z2ZHrpXk=;
 b=gIGnv7fEArdKZtJZ9TGIo30Y4joRqQpz/ow3VkuqfScWJQOSik66FWaZQl7Bh5D0sqz4NxE/EtrwiwHUfkCZ6pBuRqS2ms5DUr/GUU4kCNx/3a4EgkukWZqRgcPG55g/TkwNzb6w5HbljQZ3At70rdmQ5Aae82gk/Hil61527TQVFokkneptHaKJ1N/2A9G9z4FuRf5ZBfkG5WAATfk5lhBhBgt1bgIU4cjf1iI/bul4QABaIgmxcJHLxdLjt+tF18Aky6luW2PI7SwRFdRj1zHKAydo1mucp7YmjRkBJhBymBHLTZikYdc/YQLoAd6ONWN64t3vV6YkbmTnPL7BtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2EygqyGuTHu0SObEAePsjWfhGiLtN+WUy9z2ZHrpXk=;
 b=qGODKUehbi62ExVba1bGRQHapAwiY9XKrcoUq8F4J6Oc44h+T4xkcB3O27PY1KalOpuht7SGvAuPg53egrdb62tJghxdtMYoseTtN3I7SHY1T0p0q/VVxcSi0UkYcB685Gwmx0aNNMblMC+tdXaoLNt2TEFHoPIDAYJIGcPaCWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2709.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 15:28:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 15:28:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 15:27:59 +0000
Message-Id: <DGPUMHQSACGL.1ITBM2W573WD1@garyguo.net>
Cc: <a.hindborg@kernel.org>, <alex.gaynor@gmail.com>,
 <aliceryhl@google.com>, <benjamin.tissoires@redhat.com>,
 <benno.lossin@proton.me>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <dakr@kernel.org>, <db48x@db48x.net>,
 <gary@garyguo.net>, <jikos@kernel.org>, <ojeda@kernel.org>,
 <peter.hutterer@who-t.net>, <tmgross@umich.edu>
Subject: Re: [PATCH v6 1/2] rust: core abstractions for HID drivers
From: "Gary Guo" <gary@garyguo.net>
To: "Rahul Rameshbabu" <sergeantsagara@protonmail.com>,
 <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260222215611.79760-1-sergeantsagara@protonmail.com>
 <20260222215611.79760-2-sergeantsagara@protonmail.com>
In-Reply-To: <20260222215611.79760-2-sergeantsagara@protonmail.com>
X-ClientProxiedBy: LO6P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2709:EE_
X-MS-Office365-Filtering-Correlation-Id: df13016c-4962-433e-7954-08de7614cd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	iUUC/524CTczaY6vHoI0LFb/72DXyoJJONLOEM9RI/VpY2iG++qdmA46KWsZitZ3mMGyVC+SWRdJmueuUS8cmvYI0/wRHjto6qUlulrsMl1SGruM5VHJn2gMyltzUqRph60wPZJd3raczzsxqtYJ5D5XwYUHg1B5pHPeyc9GQpT4OzAhpV5aJSbDM6Ia5Qgy6ixTuwZVLU428zo6SJIenfx7/IvvLIeCtJ86Tk7rDv+TFbnycT2eUdnv+JHnDgA2ClKXykkQj4FwzXrO+y++Bxlliaev8wp9J9a1GQXMj892jQ2w47vm9X2byWdk/ybTbfe4dFAsKT1CNDV36kYYF/jdO/1dYq/Q1UUpzoFP8Vf72+SqTOy+8jbC3g+Y3+K/UwHBa2GW6zvW9yVTttIPkaIG1ElfcdH5x6tRbpgUgij8unZ9xplbcZaCbMJTxQuTVAwolI8DLn2Xv6prDkAJtXhjBznMTA4nxpZ0nPiC7HL8uZciASSHVAKWsAzDtJ6okkVkl0FOuv2rU43iCvoMki9q7WIm7MG15FQxRYbwGiir56hf9D8q5bSiKJlCYjtFzhu+GvREBpvIz7DdbNC0r9iq6qCkB2kwCspicPpWgGze3wwGiG+4Ps79eKRvb5cLzqyOrPozprcdrC2n57VgPjOE/eB1EdxdCke6xjiGGb4A1YnAtKIpBnCN63gMd7kHX0u4SV0qpHbgOUICoTU7RDimJt+seCODv2rPcGW3ABM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZllGNUlCSkdZWWZ0VVlFKzdTbm5PbXBIM1pML09UOHorMHUzRnRBWFpnTVZl?=
 =?utf-8?B?dGdtd3lBSWxMeDZxSjBxN3pKUytmQ1QyaTVQN2JWQmxHTVFwRzNvTzErOWY3?=
 =?utf-8?B?S1A3UWRhRU5zSk85RUFRZmNEOTVOZ3FNaVdocTRHZjdtUUE1UVlJc0k4Q00x?=
 =?utf-8?B?NkplUTVZNHU1L1hwY3hhcnFYc1lBZHlnZjlkTHBYc2pWdGZGZjAreTlDQmNv?=
 =?utf-8?B?RmN2OXJtbkJWTXRYTVg1bTBGZUpHQmhtSFFjODBUcDdITHFvZDRpKzc5K2hs?=
 =?utf-8?B?N0FYeTV4RDU0Uk90ME5SeFJqc0lzWmJsaWlsMGptK3pSakRJZUZRNG1pNWRa?=
 =?utf-8?B?dkw5aGYwSDJsMnh4Y3JSUzVJT2M5Qi9sc1BrcnlIRUNxR1hldkhuemRnaVdG?=
 =?utf-8?B?eHBXTGhPb2dlSERUZTIwaGxHL3VQSm9BZmdoMGN4bmQ4Y3ZnUHh4bDdmWVFz?=
 =?utf-8?B?M2lwVU8xZDFtZG93V2c1QkJiY1F0Rlc2UEZxdGlJM0ZNMjRwOVNIbjZNN2d3?=
 =?utf-8?B?VXVob3pFQ25wMzcvdEJqR25iZ3RTYnZITTA1TkwzcFhZNG5wQkhCTHBvUlNQ?=
 =?utf-8?B?c09DMVorcTlsdlM4NEszK2hibzM0L3MwZWd3Qjg0UzEvVXdqYWxESElZZ202?=
 =?utf-8?B?VTFqbWkrZEJBbHJxN2g5NUxEUUFhdmpLRlVRUDdDdVUvR0l2VTh1SVV0U1B0?=
 =?utf-8?B?VzNSUWNEVHR0eENJVS9uUDcwUW1RS3AzVmZWbWlDOUJVUTJESyt5T0lPQXpq?=
 =?utf-8?B?Yit1Nm9IZXB2NkxjbGZCNngrS2hsNjQxN25Lb2lEcVFuMGxXVEpjTlhBRXgz?=
 =?utf-8?B?eUd5NWZpMlJ1SCtMTHd1WWNNbC8yZXk2akRaRFJuanpiNnFDSmJnVzJaOTEw?=
 =?utf-8?B?bHJGQ2QzK0Y5VVpsdzQ5SWNEQXlGalY0bHlkcElPYmxMem1ZVEVWb3JoamhZ?=
 =?utf-8?B?TFRIQzgzc0JtbjN4Vmh2RWdFMkpiUUt2KzdSNFpEcUYza09tM254NWZFMkY4?=
 =?utf-8?B?QkJyeDREZFFoRGpROE1PRzc3d29tZ1hZRy9TQi9vZzdDbHBWSklxZmtKaGNN?=
 =?utf-8?B?a1FJcTZjamFMeDVlVHgwTW85TkpJYnE1bEdsMlNIUFViVGUzTzN0dUNrcEVM?=
 =?utf-8?B?R2tmWUpNUm5WNnYxQ2pYR3ZHY0JaOC9jYzBJMUZ4cWVTbGhxcjBidWpkNHFi?=
 =?utf-8?B?Qkp5aWVDU0tqa0VJMW5mU0duVUhDNFZFZHlQaTlEV2FSWVluWkhNSE1rbTVV?=
 =?utf-8?B?dFh0eU0rakR5aU9QM3Q1ZFFvNzZBc2ZJYWh1V2Y4QjBJWjRmVUhsLzljbVov?=
 =?utf-8?B?SlU3SGVQa1hsTEk2SFdIOVN3TkRPMmxQWTBMVjN5dnVQNmZGOGtGMzZ1dmVq?=
 =?utf-8?B?czl1V1dXQ2MyUmJIcHN6MnhTMWNRQXlQKy9ZdHJwNXVmbUE1TnZHSUVSN3gw?=
 =?utf-8?B?QThHY2ZCb3pZRWcveUtwSUF4eTlaSERsZHcyNXQ4dWtJM3RIV0d1T2lmcnNO?=
 =?utf-8?B?OTJxSEk5Z3RidTdrRVFmSjFDc3pGM3MrT2xlZjUwTzkyZkxwS1RaajF5cmVV?=
 =?utf-8?B?Y1RvamlranNpM2E1bTJaN0djbXNTQ0lOK1NYUE5IVjgwTThKbjZGcys1UDRO?=
 =?utf-8?B?ZjZPSlBYUUVKRFpWcU5EcXAxNjlmTTBlK1FQKzUxQVdhQlNCck05R2NycHdm?=
 =?utf-8?B?SU4rREhiVFF1MnlOWjN6Y3dGLzh2ZnZCWVJ3dmt4SXVPTGN0dW1SZ2s3L0VE?=
 =?utf-8?B?cGpsNVJxWk5WRVpjdFZ3STk3Lzk0clhzTmpyRDN3RklMaTZlUEF3S0VSZ1BU?=
 =?utf-8?B?YUFLMS9ON25ielJhWVNlVENJYVRkU0dtL0dMRkhQVS96MlVNQVpJS29Ia1gr?=
 =?utf-8?B?cmYzSXA2K1FIOVlQOEVsWmorZVFkM0pucXJZV3h2K1pMZTV3alNiSEFqbktq?=
 =?utf-8?B?RVVRbDd4Qys1bnR0bDl4L3l3Tldrb2dTTVhEOWVDb08vTUJrK0pRRVJsQUx4?=
 =?utf-8?B?M2doOFkwMEFPMzQyeXFrbHE1UHc0cGRzajZNd1MxaXVTT01TNDkvLzdnK3gr?=
 =?utf-8?B?aHdkempjcUQyVEhFalhNaWlOc3A0OGd2cGdnRUFYL1hwdGViNExtcEdpZG02?=
 =?utf-8?B?WUQ2dU40RFpGUlJCKzRndXI5emd5dlUxWWQ2UE01M1BtaHExWUxGVGVwSmFt?=
 =?utf-8?B?VWtqckRxcU9lb0dKRks1Vm1JRFR1YVFUMGNweEd0dms4TEMwTWJrVVFsY3Ja?=
 =?utf-8?B?dkRITWx3Zkh5amY5OTZNWXpOb3VpNlZkNzNjdnIxaXdNRHZsaUhvVlB2RVNj?=
 =?utf-8?B?QUxBNWhJNWRGWVNtbE51L2dNRHIvRklvRnZtZ3pTVmJFTHllQzFHZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: df13016c-4962-433e-7954-08de7614cd93
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:28:05.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KL/Eruzs0tewDDN8rMrvL/wSAohJRulmDCylrG5kOH3whZ+JJvDnr4R1EJ6LGMia0WKrqDEjioaK32De/Vs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2709

On Sun Feb 22, 2026 at 9:56 PM GMT, Rahul Rameshbabu wrote:
> These abstractions enable the development of HID drivers in Rust by bindi=
ng
> with the HID core C API. They provide Rust types that map to the
> equivalents in C. In this initial draft, only hid_device and hid_device_i=
d
> are provided direct Rust type equivalents. hid_driver is specially wrappe=
d
> with a custom Driver type. The module_hid_driver! macro provides analogou=
s
> functionality to its C equivalent. Only the .report_fixup callback is
> binded to Rust so far.
>
> Future work for these abstractions would include more bindings for common
> HID-related types, such as hid_field, hid_report_enum, and hid_report as
> well as more bus callbacks. Providing Rust equivalents to useful core HID
> functions will also be necessary for HID driver development in Rust.
>
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
> ---
>
> Notes:
>     Changelog:
>    =20
>         v5->v6:
>           * Converted From<u16> for Group to TryFrom<u16> to properly han=
dle
>             error case
>           * Renamed into method for Group to into_u16 to not conflate wit=
h the
>             From trait
>           * Refactored new upstream changes to RegistrationOps
>           * Implemented DriverLayout trait for hid::Adapter<T>
>         v4->v5:
>           * Add rust/ to drivers/hid/Makefile
>           * Implement RawDeviceIdIndex trait
>         v3->v4:
>           * Removed specifying tree in MAINTAINERS file since that is up =
for
>             debate
>           * Minor rebase cleanup
>           * Moved driver logic under drivers/hid/rust
>         v2->v3:
>           * Implemented AlwaysRefCounted trait using embedded struct devi=
ce's
>             reference counts instead of the separate reference counter in=
 struct
>             hid_device
>           * Used &raw mut as appropriate
>           * Binded include/linux/device.h for get_device and put_device
>           * Cleaned up various comment related formatting
>           * Minified dev_err! format string
>           * Updated Group enum to be repr(u16)
>           * Implemented From<u16> trait for Group
>           * Added TODO comment when const_trait_impl stabilizes
>           * Made group getter functions return a Group variant instead of=
 a raw
>             number
>           * Made sure example code builds
>         v1->v2:
>           * Binded drivers/hid/hid-ids.h for use in Rust drivers
>           * Remove pre-emptive referencing of a C HID driver instance bef=
ore
>             it is fully initialized in the driver registration path
>           * Moved static getters to generic Device trait implementation, =
so
>             they can be used by all device::DeviceContext
>           * Use core macros for supporting DeviceContext transitions
>           * Implemented the AlwaysRefCounted and AsRef traits
>           * Make use for dev_err! as appropriate
>         RFC->v1:
>           * Use Danilo's core infrastructure
>           * Account for HID device groups
>           * Remove probe and remove callbacks
>           * Implement report_fixup support
>           * Properly comment code including SAFETY comments
>
>  MAINTAINERS                     |   8 +
>  drivers/hid/Kconfig             |   2 +
>  drivers/hid/Makefile            |   2 +
>  drivers/hid/rust/Kconfig        |  12 +
>  rust/bindings/bindings_helper.h |   3 +
>  rust/kernel/hid.rs              | 530 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   2 +
>  7 files changed, 559 insertions(+)
>  create mode 100644 drivers/hid/rust/Kconfig
>  create mode 100644 rust/kernel/hid.rs
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8d8a5c41597..1fee14024fa2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11319,6 +11319,14 @@ F:	include/uapi/linux/hid*
>  F:	samples/hid/
>  F:	tools/testing/selftests/hid/
> =20
> +HID CORE LAYER [RUST]
> +M:	Rahul Rameshbabu <sergeantsagara@protonmail.com>
> +R:	Benjamin Tissoires <bentiss@kernel.org>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hid/rust/*.rs
> +F:	rust/kernel/hid.rs
> +
>  HID LOGITECH DRIVERS
>  R:	Filipe La=C3=ADns <lains@riseup.net>
>  L:	linux-input@vger.kernel.org
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index c1d9f7c6a5f2..750c2d49a806 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1439,6 +1439,8 @@ endmenu
> =20
>  source "drivers/hid/bpf/Kconfig"
> =20
> +source "drivers/hid/rust/Kconfig"
> +
>  source "drivers/hid/i2c-hid/Kconfig"
> =20
>  source "drivers/hid/intel-ish-hid/Kconfig"
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index e01838239ae6..b78ab84c47b4 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -8,6 +8,8 @@ hid-$(CONFIG_HID_HAPTIC)	+=3D hid-haptic.o
> =20
>  obj-$(CONFIG_HID_BPF)		+=3D bpf/
> =20
> +obj-$(CONFIG_RUST_HID_ABSTRACTIONS)		+=3D rust/
> +
>  obj-$(CONFIG_HID)		+=3D hid.o
>  obj-$(CONFIG_UHID)		+=3D uhid.o
> =20
> diff --git a/drivers/hid/rust/Kconfig b/drivers/hid/rust/Kconfig
> new file mode 100644
> index 000000000000..d3247651829e
> --- /dev/null
> +++ b/drivers/hid/rust/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "Rust HID support"
> +
> +config RUST_HID_ABSTRACTIONS
> +	bool "Rust HID abstractions support"
> +	depends on RUST
> +	depends on HID=3Dy
> +	help
> +	  Adds support needed for HID drivers written in Rust. It provides a
> +	  wrapper around the C hid core.
> +
> +endmenu # Rust HID support
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 083cc44aa952..200e58af27a3 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -48,6 +48,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/cred.h>
>  #include <linux/debugfs.h>
> +#include <linux/device.h>
>  #include <linux/device/faux.h>
>  #include <linux/dma-direction.h>
>  #include <linux/dma-mapping.h>
> @@ -60,6 +61,8 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/io-pgtable.h>
> +#include <linux/hid.h>
> +#include "../../drivers/hid/hid-ids.h"
>  #include <linux/ioport.h>
>  #include <linux/jiffies.h>
>  #include <linux/jump_label.h>
> diff --git a/rust/kernel/hid.rs b/rust/kernel/hid.rs
> new file mode 100644
> index 000000000000..b9db542d923a
> --- /dev/null
> +++ b/rust/kernel/hid.rs
> @@ -0,0 +1,530 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Rahul Rameshbabu <sergeantsagara@protonmail.com>
> +
> +//! Abstractions for the HID interface.
> +//!
> +//! C header: [`include/linux/hid.h`](srctree/include/linux/hid.h)
> +
> +use crate::{
> +    device,
> +    device_id::{
> +        RawDeviceId,
> +        RawDeviceIdIndex, //
> +    },
> +    driver,
> +    error::*,
> +    prelude::*,
> +    types::Opaque, //
> +};
> +use core::{
> +    marker::PhantomData,
> +    ptr::{
> +        addr_of_mut,
> +        NonNull, //
> +    } //
> +};
> +
> +/// Indicates the item is static read-only.
> +///
> +/// Refer to [Device Class Definition for HID 1.11]
> +/// Section 6.2.2.5 Input, Output, and Feature Items.
> +///
> +/// [Device Class Definition for HID 1.11]: https://www.usb.org/sites/de=
fault/files/hid1_11.pdf
> +pub const MAIN_ITEM_CONSTANT: u8 =3D bindings::HID_MAIN_ITEM_CONSTANT as=
 u8;

These can be bitflags with `impl_flags!`?

> +
> +/// Indicates the item represents data from a physical control.
> +///
> +/// Refer to [Device Class Definition for HID 1.11]
> +/// Section 6.2.2.5 Input, Output, and Feature Items.
> +///
> +/// [Device Class Definition for HID 1.11]: https://www.usb.org/sites/de=
fault/files/hid1_11.pdf
> +pub const MAIN_ITEM_VARIABLE: u8 =3D bindings::HID_MAIN_ITEM_VARIABLE as=
 u8;
> +
> +/// Indicates the item should be treated as a relative change from the p=
revious
> +/// report.
> +///
> +/// Refer to [Device Class Definition for HID 1.11]
> +/// Section 6.2.2.5 Input, Output, and Feature Items.
> +///
> +/// [Device Class Definition for HID 1.11]: https://www.usb.org/sites/de=
fault/files/hid1_11.pdf
> +pub const MAIN_ITEM_RELATIVE: u8 =3D bindings::HID_MAIN_ITEM_RELATIVE as=
 u8;
> +
> +/// Indicates the item should wrap around when reaching the extreme high=
 or
> +/// extreme low values.
> +///
> +/// Refer to [Device Class Definition for HID 1.11]
> +/// Section 6.2.2.5 Input, Output, and Feature Items.
> +///
> +/// [Device Class Definition for HID 1.11]: https://www.usb.org/sites/de=
fault/files/hid1_11.pdf
> +pub const MAIN_ITEM_WRAP: u8 =3D bindings::HID_MAIN_ITEM_WRAP as u8;
> +
> +/// Indicates the item should wrap around when reaching the extreme high=
 or
> +/// extreme low values.
> +///
> +/// Refer to [Device Class Definition for HID 1.11]
> +/// Section 6.2.2.5 Input, Output, and Feature Items.
> +///
> +/// [Device Class Definition for HID 1.11]: https://www.usb.org/sites/de=
fault/files/hid1_11.pdf
> +pub const MAIN_ITEM_NONLINEAR: u8 =3D bindings::HID_MAIN_ITEM_NONLINEAR =
as u8;
> +
> +/// Indicates whether the control has a preferred state it will physical=
ly
> +/// return to without user intervention.
> +///
> +/// Refer to [Device Class Definition for HID 1.11]
> +/// Section 6.2.2.5 Input, Output, and Feature Items.
> +///
> +/// [Device Class Definition for HID 1.11]: https://www.usb.org/sites/de=
fault/files/hid1_11.pdf
> +pub const MAIN_ITEM_NO_PREFERRED: u8 =3D bindings::HID_MAIN_ITEM_NO_PREF=
ERRED as u8;
> +
> +/// Indicates whether the control has a physical state where it will not=
 send
> +/// any reports.
> +///
> +/// Refer to [Device Class Definition for HID 1.11]
> +/// Section 6.2.2.5 Input, Output, and Feature Items.
> +///
> +/// [Device Class Definition for HID 1.11]: https://www.usb.org/sites/de=
fault/files/hid1_11.pdf
> +pub const MAIN_ITEM_NULL_STATE: u8 =3D bindings::HID_MAIN_ITEM_NULL_STAT=
E as u8;
> +
> +/// Indicates whether the control requires host system logic to change s=
tate.
> +///
> +/// Refer to [Device Class Definition for HID 1.11]
> +/// Section 6.2.2.5 Input, Output, and Feature Items.
> +///
> +/// [Device Class Definition for HID 1.11]: https://www.usb.org/sites/de=
fault/files/hid1_11.pdf
> +pub const MAIN_ITEM_VOLATILE: u8 =3D bindings::HID_MAIN_ITEM_VOLATILE as=
 u8;
> +
> +/// Indicates whether the item is fixed size or a variable buffer of byt=
es.
> +///
> +/// Refer to [Device Class Definition for HID 1.11]
> +/// Section 6.2.2.5 Input, Output, and Feature Items.
> +///
> +/// [Device Class Definition for HID 1.11]: https://www.usb.org/sites/de=
fault/files/hid1_11.pdf
> +pub const MAIN_ITEM_BUFFERED_BYTE: u8 =3D bindings::HID_MAIN_ITEM_BUFFER=
ED_BYTE as u8;
> +
> +/// HID device groups are intended to help categories HID devices based =
on a set
> +/// of common quirks and logic that they will require to function correc=
tly.
> +#[repr(u16)]
> +pub enum Group {
> +    /// Used to match a device against any group when probing.
> +    Any =3D bindings::HID_GROUP_ANY as u16,
> +
> +    /// Indicates a generic device that should need no custom logic from=
 the
> +    /// core HID stack.
> +    Generic =3D bindings::HID_GROUP_GENERIC as u16,
> +
> +    /// Maps multitouch devices to hid-multitouch instead of hid-generic=
.
> +    Multitouch =3D bindings::HID_GROUP_MULTITOUCH as u16,
> +
> +    /// Used for autodetecing and mapping of HID sensor hubs to
> +    /// hid-sensor-hub.
> +    SensorHub =3D bindings::HID_GROUP_SENSOR_HUB as u16,
> +
> +    /// Used for autodetecing and mapping Win 8 multitouch devices to se=
t the
> +    /// needed quirks.
> +    MultitouchWin8 =3D bindings::HID_GROUP_MULTITOUCH_WIN_8 as u16,
> +
> +    // Vendor-specific device groups.
> +    /// Used to distinguish Synpatics touchscreens from other products. =
The
> +    /// touchscreens will be handled by hid-multitouch instead, while ev=
erything
> +    /// else will be managed by hid-rmi.
> +    RMI =3D bindings::HID_GROUP_RMI as u16,
> +
> +    /// Used for hid-core handling to automatically identify Wacom devic=
es and
> +    /// have them probed by hid-wacom.
> +    Wacom =3D bindings::HID_GROUP_WACOM as u16,
> +
> +    /// Used by logitech-djreceiver and logitech-djdevice to autodetect =
if
> +    /// devices paied to the DJ receivers are DJ devices and handle them=
 with
> +    /// the device driver.
> +    LogitechDJDevice =3D bindings::HID_GROUP_LOGITECH_DJ_DEVICE as u16,
> +
> +    /// Since the Valve Steam Controller only has vendor-specific usages=
,
> +    /// prevent hid-generic from parsing its reports since there would b=
e
> +    /// nothing hid-generic could do for the device.
> +    Steam =3D bindings::HID_GROUP_STEAM as u16,
> +
> +    /// Used to differentiate 27 Mhz frequency Logitech DJ devices from =
other
> +    /// Logitech DJ devices.
> +    Logitech27MHzDevice =3D bindings::HID_GROUP_LOGITECH_27MHZ_DEVICE as=
 u16,
> +
> +    /// Used for autodetecting and mapping Vivaldi devices to hid-vivald=
i.
> +    Vivaldi =3D bindings::HID_GROUP_VIVALDI as u16,
> +}
> +
> +// TODO: use `const_trait_impl` once stabilized:
> +//
> +// ```
> +// impl const From<Group> for u16 {
> +//     /// [`Group`] variants are represented by [`u16`] values.
> +//     fn from(value: Group) -> Self {
> +//         value as Self
> +//     }
> +// }
> +// ```
> +impl Group {
> +    /// Internal function used to convert [`Group`] variants into [`u16`=
].
> +    const fn into_u16(self) -> u16 {

This and many functions in the abstraction can be `#[inline]`.

> +        self as u16
> +    }
> +}
> +
> +impl TryFrom<u16> for Group {
> +    type Error =3D &'static str;
> +
> +    /// [`u16`] values can be safely converted to [`Group`] variants.
> +    fn try_from(value: u16) -> Result<Group, Self::Error> {
> +        match value.into() {
> +            bindings::HID_GROUP_GENERIC =3D> Ok(Group::Generic),
> +            bindings::HID_GROUP_MULTITOUCH =3D> Ok(Group::Multitouch),
> +            bindings::HID_GROUP_SENSOR_HUB =3D> Ok(Group::SensorHub),
> +            bindings::HID_GROUP_MULTITOUCH_WIN_8 =3D> Ok(Group::Multitou=
chWin8),
> +            bindings::HID_GROUP_RMI =3D> Ok(Group::RMI),
> +            bindings::HID_GROUP_WACOM =3D> Ok(Group::Wacom),
> +            bindings::HID_GROUP_LOGITECH_DJ_DEVICE =3D> Ok(Group::Logite=
chDJDevice),
> +            bindings::HID_GROUP_STEAM =3D> Ok(Group::Steam),
> +            bindings::HID_GROUP_LOGITECH_27MHZ_DEVICE =3D> Ok(Group::Log=
itech27MHzDevice),
> +            bindings::HID_GROUP_VIVALDI =3D> Ok(Group::Vivaldi),
> +            _ =3D> Err("Unknown HID group encountered!"),

Please define a custom error type or just use a kernel error code.

> +        }
> +    }
> +}
> +
> +/// The HID device representation.
> +///
> +/// This structure represents the Rust abstraction for a C `struct hid_d=
evice`.
> +/// The implementation abstracts the usage of an already existing C `str=
uct
> +/// hid_device` within Rust code that we get passed from the C side.
> +///
> +/// # Invariants
> +///
> +/// A [`Device`] instance represents a valid `struct hid_device` created=
 by the
> +/// C portion of the kernel.
> +#[repr(transparent)]
> +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
> +    Opaque<bindings::hid_device>,
> +    PhantomData<Ctx>,
> +);
> +
> +impl<Ctx: device::DeviceContext> Device<Ctx> {
> +    fn as_raw(&self) -> *mut bindings::hid_device {
> +        self.0.get()
> +    }
> +
> +    /// Returns the HID transport bus ID.
> +    pub fn bus(&self) -> u16 {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct hid_dev=
ice`
> +        unsafe { *self.as_raw() }.bus
> +    }
> +
> +    /// Returns the HID report group.
> +    pub fn group(&self) -> Result<Group, &'static str> {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct hid_dev=
ice`
> +        unsafe { *self.as_raw() }.group.try_into()
> +    }
> +
> +    /// Returns the HID vendor ID.
> +    pub fn vendor(&self) -> u32 {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct hid_dev=
ice`
> +        unsafe { *self.as_raw() }.vendor
> +    }
> +
> +    /// Returns the HID product ID.
> +    pub fn product(&self) -> u32 {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct hid_dev=
ice`
> +        unsafe { *self.as_raw() }.product
> +    }
> +}
> +
> +// SAFETY: `Device` is a transparent wrapper of a type that doesn't depe=
nd on `Device`'s generic
> +// argument.
> +kernel::impl_device_context_deref!(unsafe { Device });
> +kernel::impl_device_context_into_aref!(Device);
> +
> +// SAFETY: Instances of `Device` are always reference-counted.
> +unsafe impl crate::types::AlwaysRefCounted for Device {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
> +        unsafe { bindings::get_device(&raw mut (*self.as_raw()).dev) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s non-zero.
> +        unsafe { bindings::put_device(&raw mut (*obj.cast::<bindings::hi=
d_device>().as_ptr()).dev) }
> +    }
> +}
> +
> +impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<C=
tx> {
> +    fn as_ref(&self) -> &device::Device<Ctx> {
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a=
 pointer to a valid
> +        // `struct hid_device`.
> +        let dev =3D unsafe { addr_of_mut!((*self.as_raw()).dev) };
> +
> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::from_raw(dev) }
> +    }
> +}
> +
> +/// Abstraction for the HID device ID structure `struct hid_device_id`.
> +#[repr(transparent)]
> +#[derive(Clone, Copy)]
> +pub struct DeviceId(bindings::hid_device_id);
> +
> +impl DeviceId {
> +    /// Equivalent to C's `HID_USB_DEVICE` macro.
> +    ///
> +    /// Create a new `hid::DeviceId` from a group, vendor ID, and device=
 ID
> +    /// number.

The main description should be the first sentence, and C equivalent sentenc=
e
follows.

> +    pub const fn new_usb(group: Group, vendor: u32, product: u32) -> Sel=
f {
> +        Self(bindings::hid_device_id {
> +            bus: 0x3, // BUS_USB
> +            group: group.into_u16(),
> +            vendor,
> +            product,
> +            driver_data: 0,
> +        })
> +    }
> +
> +    /// Returns the HID transport bus ID.
> +    pub fn bus(&self) -> u16 {
> +        self.0.bus
> +    }
> +
> +    /// Returns the HID report group.
> +    pub fn group(&self) -> Result<Group, &'static str> {
> +        self.0.group.try_into()
> +    }
> +
> +    /// Returns the HID vendor ID.
> +    pub fn vendor(&self) -> u32 {
> +        self.0.vendor
> +    }
> +
> +    /// Returns the HID product ID.
> +    pub fn product(&self) -> u32 {
> +        self.0.product
> +    }
> +}
> +
> +// SAFETY:
> +// * `DeviceId` is a `#[repr(transparent)` wrapper of `hid_device_id` an=
d does not add
> +//   additional invariants, so it's safe to transmute to `RawType`.
> +// * `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
> +unsafe impl RawDeviceId for DeviceId {
> +    type RawType =3D bindings::hid_device_id;
> +}
> +
> +// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field=
.
> +unsafe impl RawDeviceIdIndex for DeviceId {
> +    const DRIVER_DATA_OFFSET: usize =3D core::mem::offset_of!(bindings::=
hid_device_id, driver_data);
> +
> +    fn index(&self) -> usize {
> +        self.0.driver_data
> +    }
> +}
> +
> +/// [`IdTable`] type for HID.
> +pub type IdTable<T> =3D &'static dyn kernel::device_id::IdTable<DeviceId=
, T>;
> +
> +/// Create a HID [`IdTable`] with its alias for modpost.
> +#[macro_export]
> +macro_rules! hid_device_table {
> +    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $ta=
ble_data: expr) =3D> {
> +        const $table_name: $crate::device_id::IdArray<
> +            $crate::hid::DeviceId,
> +            $id_info_type,
> +            { $table_data.len() },
> +        > =3D $crate::device_id::IdArray::new($table_data);
> +
> +        $crate::module_device_table!("hid", $module_table_name, $table_n=
ame);
> +    };
> +}
> +
> +/// The HID driver trait.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::{bindings, device, hid};
> +///
> +/// struct MyDriver;
> +///
> +/// kernel::hid_device_table!(
> +///     HID_TABLE,
> +///     MODULE_HID_TABLE,
> +///     <MyDriver as hid::Driver>::IdInfo,
> +///     [(
> +///         hid::DeviceId::new_usb(
> +///             hid::Group::Steam,
> +///             bindings::USB_VENDOR_ID_VALVE,
> +///             bindings::USB_DEVICE_ID_STEAM_DECK,
> +///         ),
> +///         (),
> +///     )]
> +/// );
> +///
> +/// #[vtable]
> +/// impl hid::Driver for MyDriver {
> +///     type IdInfo =3D ();
> +///     const ID_TABLE: hid::IdTable<Self::IdInfo> =3D &HID_TABLE;
> +///
> +///     /// This function is optional to implement.
> +///     fn report_fixup<'a, 'b: 'a>(_hdev: &hid::Device<device::Core>, r=
desc: &'b mut [u8]) -> &'a [u8] {
> +///         // Perform some report descriptor fixup.
> +///         rdesc
> +///     }
> +/// }
> +/// ```
> +/// Drivers must implement this trait in order to get a HID driver regis=
tered.
> +/// Please refer to the `Adapter` documentation for an example.
> +#[vtable]
> +pub trait Driver: Send {
> +    /// The type holding information about each device id supported by t=
he driver.
> +    // TODO: Use `associated_type_defaults` once stabilized:
> +    //
> +    // ```
> +    // type IdInfo: 'static =3D ();
> +    // ```
> +    type IdInfo: 'static;
> +
> +    /// The table of device ids supported by the driver.
> +    const ID_TABLE: IdTable<Self::IdInfo>;
> +
> +    /// Called before report descriptor parsing. Can be used to mutate t=
he
> +    /// report descriptor before the core HID logic processes the descri=
ptor.
> +    /// Useful for problematic report descriptors that prevent HID devic=
es from
> +    /// functioning correctly.
> +    ///
> +    /// Optional to implement.
> +    fn report_fixup<'a, 'b: 'a>(_hdev: &Device<device::Core>, _rdesc: &'=
b mut [u8]) -> &'a [u8] {

I think this can just use a single lifetime?

> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// An adapter for the registration of HID drivers.
> +pub struct Adapter<T: Driver>(T);
> +
> +// SAFETY:
> +// - `bindings::hid_driver` is a C type declared as `repr(C)`.
> +// - `T` is the type of the driver's device private data.
> +// - `struct hid_driver` embeds a `struct device_driver`.
> +// - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `=
struct device_driver`.
> +unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
> +    type DriverType =3D bindings::hid_driver;
> +    type DriverData =3D T;
> +    const DEVICE_DRIVER_OFFSET: usize =3D core::mem::offset_of!(Self::Dr=
iverType, driver);
> +}
> +
> +// SAFETY: A call to `unregister` for a given instance of `DriverType` i=
s guaranteed to be valid if
> +// a preceding call to `register` has been successful.
> +unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> =
{
> +    unsafe fn register(
> +        hdrv: &Opaque<Self::DriverType>,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result {
> +        // SAFETY: It's safe to set the fields of `struct hid_driver` on=
 initialization.
> +        unsafe {
> +            (*hdrv.get()).name =3D name.as_char_ptr();
> +            (*hdrv.get()).id_table =3D T::ID_TABLE.as_ptr();
> +            (*hdrv.get()).report_fixup =3D if T::HAS_REPORT_FIXUP {
> +                Some(Self::report_fixup_callback)
> +            } else {
> +                None
> +            };
> +        }
> +
> +        // SAFETY: `hdrv` is guaranteed to be a valid `DriverType`
> +        to_result(unsafe {
> +            bindings::__hid_register_driver(hdrv.get(), module.0, name.a=
s_char_ptr())
> +        })
> +    }
> +
> +    unsafe fn unregister(hdrv: &Opaque<Self::DriverType>) {
> +        // SAFETY: `hdrv` is guaranteed to be a valid `DriverType`
> +        unsafe { bindings::hid_unregister_driver(hdrv.get()) }
> +    }
> +}
> +
> +impl<T: Driver + 'static> Adapter<T> {
> +    extern "C" fn report_fixup_callback(
> +        hdev: *mut bindings::hid_device,
> +        buf: *mut u8,
> +        size: *mut kernel::ffi::c_uint,
> +    ) -> *const u8 {
> +        // SAFETY: The HID subsystem only ever calls the report_fixup ca=
llback
> +        // with a valid pointer to a `struct hid_device`.
> +        //
> +        // INVARIANT: `hdev` is valid for the duration of
> +        // `report_fixup_callback()`.
> +        let hdev =3D unsafe { &*hdev.cast::<Device<device::Core>>() };
> +
> +        // SAFETY: The HID subsystem only ever calls the report_fixup ca=
llback
> +        // with a valid pointer to a `kernel::ffi::c_uint`.
> +        //
> +        // INVARIANT: `size` is valid for the duration of
> +        // `report_fixup_callback()`.
> +        let buf_len: usize =3D match unsafe { *size }.try_into() {

This can just be a cast. In all kernel envs `usize` is at least as large as=
 `u32`.

> +            Ok(len) =3D> len,
> +            Err(e) =3D> {
> +                dev_err!(
> +                    hdev.as_ref(),
> +                    "Cannot fix report description due to {:?}!\n",
> +                    e
> +                );
> +
> +                return buf;
> +            }
> +        };
> +
> +        // Build a mutable Rust slice from `buf` and `size`.
> +        //
> +        // SAFETY: The HID subsystem only ever calls the `report_fixup c=
allback`
> +        // with a valid pointer to a `u8` buffer.
> +        //
> +        // INVARIANT: `buf` is valid for the duration of
> +        // `report_fixup_callback()`.
> +        let rdesc_slice =3D unsafe { core::slice::from_raw_parts_mut(buf=
, buf_len) };
> +        let rdesc_slice =3D T::report_fixup(hdev, rdesc_slice);
> +
> +        match rdesc_slice.len().try_into() {

I'm somewhat inclined to just `BUG()` (i.e. `.expect()`) in this case. A dr=
iver
that hits this error condition would need to leak >=3D 4G of memory to sati=
sfy the
lifetime bound.

> +            // SAFETY: The HID subsystem only ever calls the report_fixu=
p
> +            // callback with a valid pointer to a `kernel::ffi::c_uint`.
> +            //
> +            // INVARIANT: `size` is valid for the duration of
> +            // `report_fixup_callback()`.
> +            Ok(len) =3D> unsafe { *size =3D len },
> +            Err(e) =3D> {
> +                dev_err!(
> +                    hdev.as_ref(),

as_ref() shouldn't be needed now.

Best,
Gary

> +                    "Fixed report description will not be used due to {:=
?}!\n",
> +                    e
> +                );
> +
> +                return buf;
> +            }
> +        }
> +
> +        rdesc_slice.as_ptr()
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single HID driver.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// kernel::module_hid_driver! {
> +///     type: MyDriver,
> +///     name: "Module name",
> +///     authors: ["Author name"],
> +///     description: "Description",
> +///     license: "GPL",
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! module_hid_driver {
> +    ($($f:tt)*) =3D> {
> +        $crate::module_driver!(<T>, $crate::hid::Adapter<T>, { $($f)* })=
;
> +    };
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 3da92f18f4ee..e2dcacd9369e 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -102,6 +102,8 @@
>  pub mod id_pool;
>  #[doc(hidden)]
>  pub mod impl_flags;
> +#[cfg(CONFIG_RUST_HID_ABSTRACTIONS)]
> +pub mod hid;
>  pub mod init;
>  pub mod io;
>  pub mod ioctl;

