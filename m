Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013082.outbound.protection.outlook.com [52.103.46.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E47347BA7;
	Sat,  5 Sep 2026 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645442; cv=fail; b=TnCXQ4A6qQqgsFcS7zja5Gwj1AQlU99DJERs7SXS215ycR2AnFyY2GWzTqnusw6ytC/YZkBjJmXymHpltMxx43rPE5qOJrexD7OSLnCD9P8TcUNfPWaEyhW3eStZaF3M8vMZjGpeAtZJsBce4UBZAkvw2p+R5nORKCE/Um06w3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645442; c=relaxed/simple;
	bh=nrWwJRSqmCDtPa0NII9isVnszg8TvUbi8UyDpOROKTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c3UhBPJpdphi4CvpTtQT9KiBAYI9tMb8p2z1tLZxn0J5AiJAMgkeAQK8PltEQ8eLJODVPXQRAAKmAWhyfWsTrG478VKdEI1fo7R0MtFEI0KhB1oTJ8tBmS4cv5nKHaGdkGNotDy4j9pidJJB4gZhvnFoxhzuLc7n949flBSvl9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=SpSA3uW5; arc=fail smtp.client-ip=52.103.46.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="SpSA3uW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RO1RoB3XbF5qW5Wrs8OnW/n6lRpGt6AXL1YcAU9iNeZyntriJlTJRcwX5x6p6q8TeU/aAfNDg9CSm5kGuHYjhxLOb0ywLu+qH/U3qqbiVM1C74ayKI99YW+mCFhD/wBQzWO9Ps/IKBP6u4DeRy9/tXv7mdgyy6fbuTeVGWAlmAZKYOPteRWiBwWvE9+XfcluFzlKGpxwntC/kd5xXLQcAWOOil7gOoPPhGDXOadYPrHoAOLJGw4zy9AR9eCqhreCBszR6Lq1eDYIKRB0N4m90lVTZp35eMFiP7PDsy3Hnl1JPVvDQW8jiriD3AVsRiD7IjMUJKBhZ56mJr8hiBNAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+Csm9I0YuWe3AiFv1xN6d37RBWL896QcMjjBvWWJDg=;
 b=fTeQeE7hY8JEUjaTeGSUAyopE3tk4KP0+t7nGA1K53Ku4jbHFELr1QRHfGBt1SqdOGmFniRzzEQNn6ijcQvmU4ZSCnN1ejQe7ykwc9AKWBIJ0wmQyt4WMDF7RTf7BycLgagQOiulHeZ2mhkiJlCo12AgbJbsQL/Q6lz2C84jusAsnJGC9mBR7tZqChJ9h78GzDF4yi1DXLm+S4EiH0sNaBQEMzoa5svh4mJVIqUK8ggS63iIHiqvbIf48pucOJVVaZGo73mB8ixF+fOgrPlgcFjBVq7XiYjjhm9zqy2pXMYcf4NQMWyGnfFoOKYYMqEuqm884W/jpSSDiEtdVTlZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+Csm9I0YuWe3AiFv1xN6d37RBWL896QcMjjBvWWJDg=;
 b=SpSA3uW5qn/Px2wPMaWhAY7mtBaqKUr9lSLsDx5+v6u0Q0Z/fqggYYrrPIJrgGJK5ARNgoz1DJyPW/NTeEMWKrWscWXHZDhfM/MoJGORl0FxycUzFVHdjCAHUwxtcWtvLWzQonJp9Dz2iycw6Yp3/Z0WQg+W7ZOYVge6qk85DRT0h+VS6JU0k2zfPnsdx3xI3DevheUzTe9dSQrEe+9ZkOEuSrrJDaxFXCIlw60iVN8ev19rMoMhW9nE23Vg2oAEzWXVuNHy86R52W0mrl55LGF0gShJ3/Rfph9ZiCodjtpCvLKL81TxCwuEF1+jfcacTkYzLQ2z56iINyZMPDGTkg==
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:1d9::15)
 by VI0P251MB1076.EURP251.PROD.OUTLOOK.COM (2603:10a6:800:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 21:57:18 +0000
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35]) by PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35%4]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 21:57:18 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: linux-input@vger.kernel.org
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: Re: [PATCH] HID: wacom: validate GRAPHIRE_BT report length
Date: Sat,  5 Sep 2026 22:57:14 +0100
Message-ID:
 <PAXP251MB00104D7F5F7B18F15102E8E8C8B42@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905102908.ADE1F1F00A3D@smtp.kernel.org>
References: <20260905102908.ADE1F1F00A3D@smtp.kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::13) To PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:1d9::15)
X-Microsoft-Original-Message-ID:
 <20260905215714.49526-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP251MB0010:EE_|VI0P251MB1076:EE_
X-MS-Office365-Filtering-Correlation-Id: a4497d6d-35ea-4d19-0514-08df0b98a6df
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|51005399006|23021999003|5072599009|15080799012|37011999003|25031999004|12121999013|8060799015|19110799012|25010399006|40105399003|2607281247196008|30101999006|3412199025|440099028|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBbvKZp66MTN8LIPYbs7X/5qmC0xAzZvdU0/bos95nwA/zR2xirIJ4C7TuAK?=
 =?us-ascii?Q?qMmT/zdKkXKkjhkcwL6SS2aseAlEF7PB+kCmGpspgX/Z4GEtdRQvfMKpMmQ2?=
 =?us-ascii?Q?M31Zz5nd9ZRhqTeL2Fcq+Nv1UwjteJIhoOuNcYmitgbcmZk6Ygy8j/Yws2K5?=
 =?us-ascii?Q?5JyZGKv3IoQTStDUnMQmYmWWX80nqcaVrCqu614nJghMPiJ3h/5vESQmG/qT?=
 =?us-ascii?Q?M7jle2YavmtPQcSn8UVWu8rCmgWHQvAirpKDKbrp2jbwxU9TeryioCjOK9Wj?=
 =?us-ascii?Q?n6/VDCtG3m3rNeYgsTcyjxEv8vCSJ4lQgT7pxDqagE/V0y1ar2lLS7jslJuG?=
 =?us-ascii?Q?Y3ms6Nim6PiV/6Qzfu8CN0IMH2l+YhijU9AnV+0BZN+AXqSm2aiOSfd6CHc4?=
 =?us-ascii?Q?ALEyChSuzmK1M+ugsYxQMy4s6Zwckj608b4QG4k+iq2tHr3jDMOGuIjTHgF9?=
 =?us-ascii?Q?C21YueCjzmM2SDRTXwX/3zNTlOott/xzEZIIdsIujIm3FfeDYiflfiKFuIM2?=
 =?us-ascii?Q?FELDCM38wBkzEV7Uo0pdk5cTU0M0XkBRrDiOykC3+MkjatC9EeR+v82oYelQ?=
 =?us-ascii?Q?NNJILqWePsfjqpy760dbx8HG8fkOU/P8Zg1HNt+BONJj3StGzhMv7E3Z52Of?=
 =?us-ascii?Q?RLZRy2BPP+TvqwCQatpUS4lBafeO1L/DDcDvJ6zU4Vkbq+NqZOr9IbNWbyU+?=
 =?us-ascii?Q?KoBSiq4VpO4dBKh79MWX2R3flDzQzoVTJjngt4nroJMNhmmJbEWK9puQ8sMx?=
 =?us-ascii?Q?DVpJZ3REN65Nuk5IMDnWZwonMn+xJNZMZMXI44bhC6rRwynVW7OW3pTxo3Rk?=
 =?us-ascii?Q?VQ+FL+/F+WIFH+0fGpRvNBpCwnkmJi0bNWZVywUTFIfcNZPHH6H8rTBIrL3W?=
 =?us-ascii?Q?v0cUmNA8Aqb345GjlyAQgcV4UOiwLDGEWZRieD634dDA6slvbln9QyWMskvW?=
 =?us-ascii?Q?90BhN1ZCLK4G6Uj2NWB99JBMBgz2f5QlXweF45Eae3Ti24viJeAbzx/GNNk1?=
 =?us-ascii?Q?sTkZojkfM7y8g+YCpUKE/tP36h+NIwuibel+R3gTEVDM4iRoYnQ6K0oaf0ub?=
 =?us-ascii?Q?+yWHRMZ1sKZVEOM8w6/okC1VqQ822fzm/j7sm9x/skwC+lYFBMM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?snF3AfCR3MY4Tyg48IN/lXMuKBTsjik8EBp1eVJn9ofD2y7fhtqM/4GSXrKM?=
 =?us-ascii?Q?BQ/2KmGHMCRCD+cT9K9bvAo2VWrVDajhe1VpYLLPlLwUU97Nfm60RUNyFw8M?=
 =?us-ascii?Q?FwlnsxqKmx9s10jjF7Vzyvq95ny1bRXWYPdpa1FfuI+maA6ko4zSg6P6dui3?=
 =?us-ascii?Q?8cAlZMUEJgc9I9HedL+JWkY49+qFIOuiG1Swx7H/BaIL/RLDLVbkubqnn/It?=
 =?us-ascii?Q?DBXPjuR/d8XL+9ySYnhZwZKmt2SGdmZ+rLIxF9N/08oWC3GS/EvxyEsLQ+MN?=
 =?us-ascii?Q?iPsIj+5FjsjRFBJfsohlE6VAbJw25qJlenqSn9WsSrjSbuptrpLaLEHz+cev?=
 =?us-ascii?Q?pSNcSsBDkdzrfpwQSPV/lXbVeR3pbJsFl41cHsyAwDUovF2CjE1GADekTE/Q?=
 =?us-ascii?Q?oVNRjLycDujGyKsi3doQDS1aBnK9nS+Th0egC4ZWkbhYAmp8fCVWP3c8FVkl?=
 =?us-ascii?Q?bU4QSNYwucDzbHZp4bJ2dOxuTD31jjGBQuG+14EJH0pcTBFrhNuZTvWiWJJK?=
 =?us-ascii?Q?XpIH6MusXrMLGFikxqT3r8QGDj+mR4YxKw5SNth5wf47zSXy20cfqXKQWrhp?=
 =?us-ascii?Q?NBmPbRJLY6yEGN1/LrprKlRaKS1i4bMoo3dHk+s9wTUyOUVjgrVEacWcfh8o?=
 =?us-ascii?Q?KERc/GYoi/SMZcMi1Uf1v/MWrANTFdrJbS1eA0h5GK4od+F8kUl42kLTVjsb?=
 =?us-ascii?Q?zsOB9ZUnJg2vY1LDBEnOtthKv7Gm3lLkL4Ts4bCH/XtTGE7IRX/G1BRNvh5y?=
 =?us-ascii?Q?PyCFP1QDR5ji5UdLwUbXYfofkR6c69Wf8vPN4JGhOla8nj9kVBazNKXbydov?=
 =?us-ascii?Q?VZGWiEGXkNHx/DpHta+e3s0qi+HNOV2GZ0NtvWsBXS3xuDrx22LtnId37Emf?=
 =?us-ascii?Q?WVXT7R0jFajC6hymNVQtSK92dB+iJRAYsak5MMEH3Tg990wpGBviEjvxoX3e?=
 =?us-ascii?Q?eyZucsKjq91EPEwazUuQ5H1cvPy6/1+eW/TMW+2KcRDLLFWZCN/dgvmuLxT0?=
 =?us-ascii?Q?KaMs59ftN37Ci2cT3DU3s3qmMGafg0CtiA2hyyop29AZUFLHgbLnTrQn+QlN?=
 =?us-ascii?Q?/bRNpyHzOLHRKTE00e3c7nm3A8pwysd0loBkk/eRmYIolX3+0d9ct2KoVnbn?=
 =?us-ascii?Q?oyrw3BLM2gcr35Mu3q53WhTXJvYSubT/w+qe5dHCjoez+rMp/+D4uy3YVd07?=
 =?us-ascii?Q?GqoVjdPDG5f8fZLXzKEPCBvPEJYcqg5e/QqW0NWwGvs2Qq0HUuIOtZmDE4s9?=
 =?us-ascii?Q?j/+Ct621IIReBMWwWAZwmmPJ1cni3QiDNyE6QWDR5GbfXVQSs2u2JI6OMqq8?=
 =?us-ascii?Q?Gl1eZ3uHCaCMICvmCnDZ8fgABhvJHFpZTUXlgjHar0t9HV1o39ZQujfVjuCr?=
 =?us-ascii?Q?vUcPAAz0y522B76TRO8vsIpQS5rIJPMKnTATatW7zBysxfcSlfdtLQEBOv6g?=
 =?us-ascii?Q?9Z2YIYz6exnOf1NK1zuEi1Ix3MhFtqR6?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4497d6d-35ea-4d19-0514-08df0b98a6df
X-MS-Exchange-CrossTenant-AuthSource: PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 21:57:18.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P251MB1076

On Sat, Sep 05, 2026 at 10:29:08AM +0000, Sashiko AI wrote:
> [Severity: High]
> This is a pre-existing issue, but is there a missing cancellation of
> asynchronous timers and workqueues in the wacom_probe() error path?

Partly. I checked this and the core of it is real, but narrower than
described.

The only work item that can be pending when wacom_parse_and_register()
fails is init_work. wacom_query_tablet_data() schedules it one second
out before the WL_MONITOR hid_hw_open() call, and if that call fails the
error path does not cancel it. wacom_probe() then returns the error,
__hid_device_probe() releases the devres group and frees the wacom
structure, and wacom_init_work() runs on freed memory a second later.

wireless_work, battery_work, remote_work and the timers cannot be
involved. They are only scheduled from incoming reports, and
__hid_input_report() drops every report while probe() holds
driver_input_lock, which this driver never releases early.

It is also not reachable from user input: it needs one of two devices
and hid_hw_open() failing at that moment, so I would not call it High.
I have sent a fix as a separate patch:

  HID: wacom: Cancel init_work when probe fails after scheduling it

> This isn't a bug introduced by this patch, but does this bounds check
> mistakenly limit itself to GRAPHIRE_BT devices?

The other device types served by wacom_graphire_irq() are USB, where
the transport buffer is at least 64 bytes, so a short report yields
stale bytes from the previous report rather than an out-of-bounds
read. The same applies to wacom_intuos_irq(). Extending the checks
would be reasonable hardening, and I am happy to send that separately
if the maintainers want it, but it is not a memory safety fix.

Thanks,
Aamir
