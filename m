Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9EEED8;
	Thu, 18 Jun 2026 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806627; cv=fail; b=SS5GoAZgbkkEsVVbqAztuh/ZrCGXYmO0+iXdQ7is84wi9dwZQpJLuDSHb1ymvCOgck1EouVLw2iXNnb0fNw4FcDrIH9j2uhl8J36VFI4N4YM0VvbADBAWdgPum7hopo8VJpLkYUy7VpqJUca1a5E6tmCkAxaevSSF03/46odnOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806627; c=relaxed/simple;
	bh=yvbGydKxmvbYQNxupNWR+TZTG3xSdYfsbfxyAEIdTKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IEux22IBouTS2p7UbLi4bLuaOUmVGOTIazv/Hg9fQyZYhbONOmqUlk37J1LHUmIve8+8lwieptpqPetaQvjsXj4jbxuTsW0gt1E1j09PU8X74K1MBB8PgCb1skQSt45b2rVOvwz89ltAu8Bms+fcINNOGg5fENT+ECSvNp6fElc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tOrLgIQr; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tOrLgIQr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZW3xkg+vUflfA4mpisQ25mngWB6Ss7ZgBMmxzNcE5wSpimRoc2B1giiukMVWjNWlz62JnGAw6Lmn6U3B65fIzINN/tTouXykDqXBnLuMPXbL3tXlUKhE8y7tLy2Lxhp0kLzLJLpHezbktIGztdlT0X/Mc7FCb5EVa9+KIEhSbJcle3X2gWSMTXyK+foYyJeRBKBvu7eRB7Ug7VL9WLS5Tr6+qAf/WVsBwkn2UjpCHqDSh/9RHQ3ZXykyM87BdJ+rRuGnxZOWvvX1ulSywNKlQMSq+KSRemEO3IAgrsPer9DxB1vo8TRNfIKXmUuW/fR2gqF9rtxxLGvVki213D3snQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvbGydKxmvbYQNxupNWR+TZTG3xSdYfsbfxyAEIdTKw=;
 b=mzkxkwXpUwk1PTPHJWoswqDlgtPa5ABka9f5HvbTcj4Te8Ln98KSvzaytngEtFBE73ThjdiC0G74tf22gun5pUx7ArL3EPBFESxfiaCuL6DAUz86AItFYGVyIiiLCOOekT5NVapRTAw9OFvWOVUjroHZ+ogldwC5DdN20jNmSs/6QGkBF4HlyA3uDHz7fR5JOLozeMb8uowsFcg2x4qle0KJU9freA5DxLxjC2OZTO/01s845GWT1i3jEzLQJN4ncq1kAnVRgkdmXU9uMJC6HZKEHQYFGmkHCBp3TM8ttH6xGvRyTW4QESXjUwOmtzyha2uzhr/5OL3dv1hS2jcyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvbGydKxmvbYQNxupNWR+TZTG3xSdYfsbfxyAEIdTKw=;
 b=tOrLgIQr70ZnFVfTf+oSIV96J8wnuWIuqHnsw7I2MVFDd3vglgWJC7Xgc2+Fvi0ozG/YWy38iRTKQqrtyzcHyki9CvKX08MkfxzlFa3v7l9POoRlh/z9dV87JjXpDx6NhkfEk18EkwKo9LMMmyJZKTEDAjAQw/SneIqVnV31ElCHcpgVzY6kO0Ow9VWbyL8CFmM9dMpjO8MVfWOjWSUdSSU5k30LE00YNvpWYv51u3SLLlep4zWs9d3tuTo7+4N/o51zx3xweePwAXd81j+wdAmzWesNYMRUNItHp1FN48wQLchAGpWSk+Utslvbew8E+ichS2uAJhjCknq8L/Rj3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB12185.eurprd04.prod.outlook.com (2603:10a6:800:334::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 18:17:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:17:02 +0000
Date: Thu, 18 Jun 2026 13:16:46 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] module: add SCMI device table alias support
Message-ID: <ajQ2Dt17PamZ8Ssp@SMW015318>
References: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
 <20260618-scmi-modalias-v2-1-8c7547c1be21@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-scmi-modalias-v2-1-8c7547c1be21@oss.qualcomm.com>
X-ClientProxiedBy: SA1P222CA0094.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB12185:EE_
X-MS-Office365-Filtering-Correlation-Id: ca68df37-0da0-4b71-5ee1-08decd65cb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|6133799003|22082099003|18002099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	G/djns1553n4FlgRtUIoHrp2ptF8jJwPnDvke4VXZ69MsOqO+uFSezZCrV4D3qD0QbbHDduN9cnyb05+QmOFm1b6iRrU8iinKy8+xkqa5tlS6Ilv7dW0HXG3BUpwY3my+pjrG3oeHY8szo9Jakxv5657tMnYkTgAIaOxCBYBm3IsGp3IXv8tzWuJkCUAsSMhBXvwHdESQxMvWNXWQXDbdoo4XhPHcVEb8XlXPJpzq0X9X6oFE31+6ZMrcCPQ1Q+HZwbjaSsS75tQdMDXEZ4Lk7SAoYd/elZXyNLFARNqylRm+YZj4MxqT9Ra1niILdI8LWSvIln7KOQmsYo3q0Akfx3qIiPkwFnxgaEpMoRiMx0Dmr77mpbARskWWFnYkVg1PHcgP5lOc/S0k06xnp/kFWtiOOV4mphpxPi+Idkng8EPWzP0l2A2y/30dfeU6Q6mPPEwWI+uCdai6gHyOPDBiNEpWgp6/ri0Wj7fIg3LAbp1D9aqaPKTETopGKTeaZfD0snN4TGjAl3VtMH4Z4b456o8SAQ6i/aJsIuiJHCq482/4qEgvj+MMUVRsIc1ElKWmXdqOZUL5u49D/Y49eJU2H1tUujLyUdIu6GXx3p6wya3tVy33V0JGotAyllnF0gdwbD+1+nYjI9fQWLdeHXB6/Eri0sqruqRhBKeyf600QD/bcuDB1jUyrbA5PvHDLgo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lrNfEEzEOIPfiN2ff742/PDvpwT7tlZIDjV0BsYra+6qeiS8YCus9E6sOy2y?=
 =?us-ascii?Q?CxW1JuSoIRwgXxS7fr1q4gh/biOdtGd/gqXdDdnH6/xptE+5ipki7hXKuFpC?=
 =?us-ascii?Q?YKRZa43xtISl88nzDwRlmWSCg4Hnv5ybVUTFMomdoLIU5Pc4vPXe4iszZLaC?=
 =?us-ascii?Q?GPejhH9jwpWnna5YO7eWudvfJJIE+HUZvyPGGkT6/wl6Yv7/Acmqr94+zH51?=
 =?us-ascii?Q?aZ8ifMcG60ZbLVpBmNcBUixLUS2dTtgVf7pubs9xqt/e3udNft5hRPAiBfzR?=
 =?us-ascii?Q?D32XVT5l6mjrURtFsNsW65xLblo43bXndXzOcJqjn3uFxLp2d4LLEIpWpEX+?=
 =?us-ascii?Q?vtiOKTdP+zIc//nEH7ehIqbWrcyMeE3kWWFVgg2a2KkSDtNDFwywOLI/WcUW?=
 =?us-ascii?Q?0i21veU2G1/uS9A7aspHicXefJbAA+bMxFtGpQamHY+JwwV8MbCkzrcuWcLt?=
 =?us-ascii?Q?Vx75bXh2le3RxZEJRuGP35Be4CXB6r3ZQUW8ULBEBc6eDgJKefjZ2YK84rKW?=
 =?us-ascii?Q?EV6okSOx7W+dp0WtHDUZPKcAT5YxqB8f7Y6Awvy/4L/t8B0bqBIsZEzGHFXU?=
 =?us-ascii?Q?TseR6+9+AQG49HdRfRdKefdkUPRvArzA1LRd+ifm6UGEBgTlhyD8lYlsDKJy?=
 =?us-ascii?Q?HDUBhfvY86DqE41W8nmeBq4tEHHHREIB58f4SxOw07SP+3fc2DpJW6P0R8KV?=
 =?us-ascii?Q?eL7oB3iOYjgEUcMG2sSpGkNT/5k09hB57jFMFkt+B5pVrc1OW+ta/4kdhigS?=
 =?us-ascii?Q?9NxbspvjILxrIFfix9tOxwGjDP4Tkx4k+10pJCw+NKHYsf119OZKZxmfYrbs?=
 =?us-ascii?Q?wRBYuS75oCHngGwQxKcyOdD6Ry+bpe2tcnzjKCgKhWmSkC4DCHtGunuJGPQa?=
 =?us-ascii?Q?Ju6k1SMkx3j2jA78o6LRoXXCTEI3DKcQVhVyRhCJ0mFGPTXIjlhbzZq5Aruh?=
 =?us-ascii?Q?7nhgjGcmv+K2pIWZwZ23/zu80YTzPdcN4b4o+90OO2bSyIuxhLBnAlJjA+pz?=
 =?us-ascii?Q?RkGnfTE55cSW92b9mRFt3sD5Sf60C4OQPYG5SPpjZ0a1kNrXOvNKfQ10HsOM?=
 =?us-ascii?Q?pXSOeK3fe+WjnBSAQB2/C7wBT8WKmIPChrChPCWRJPfM/H7qtdyGSaLQANNq?=
 =?us-ascii?Q?rSAVVDqXSo5IHrac/2LJ/1NwwA12RTJIrIpiN237gqsjsVZYmbcWOwlNAotF?=
 =?us-ascii?Q?f8+Daoi4Ir9Vrh276L1DWhJzT+pVe+kCDK23pRQ5sB9Tpm6VwI2xXzXku5p7?=
 =?us-ascii?Q?G2WYI2QwJEIDOEALXhyIi2SuPB5dEc8JUucAcAyGa42dB6GyUU41ykhp0o+H?=
 =?us-ascii?Q?F6B65PUtc6Hm/98unHW99KMlXXGKdCJ1wd83NiQDld8ZS9he8XrVUL3smGNB?=
 =?us-ascii?Q?g4VJySEVCHBmqf+qNsYmJQgaw3Aiw7/sNlD2l0tU8iw4fupRS1V2gXacN26K?=
 =?us-ascii?Q?01BESj3XjxGwKcCTEzpTWRZtC66BTnpZudyewmmwtx0bBn2C0q6lwnn3QEts?=
 =?us-ascii?Q?c4c7NnvKG8f1j6+pJdt8hWgE6J+nW6T/DfCZqZeSv6FVZb1VpdajTDiBUqoV?=
 =?us-ascii?Q?MXOy5PphkyfqLjyOZFNBaND6L+NWT1iQVHlKB5hI3QXFItkgcPyBdino6rc4?=
 =?us-ascii?Q?GTWeyHqmlBJrP20HfLI80EwYq3DUHUzVP0hSx7RcHYnB3caKZDb2sgR5N/oV?=
 =?us-ascii?Q?nnrkg3GQXs35ZhMWzC/S8Czxan+4TXz4zl0eeRxapV1vN1Q76ziQdoJZnNLz?=
 =?us-ascii?Q?HQOnPuyC3wZfa/sY4Nnm2zZsqQuKfzIwA5zYmUq/eNm89zFerEEE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca68df37-0da0-4b71-5ee1-08decd65cb35
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:17:02.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl7I5slZrKlGy1HY5DIzpDS3Xi5VlSVkIjtjGqVQUv9vTnoXqjBnPglQp7U2+VyTrj00BYqm2rY3YfKxPCWGsH2bJRHQco2N3c97I6IQNt8fWF8cyoINsLeAmYOeDgXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12185

On Thu, Jun 18, 2026 at 03:56:34PM +0000, Bjorn Andersson wrote:
>
> SCMI client drivers already describe their bus match data with
> MODULE_DEVICE_TABLE(scmi, ...), but modpost does not know how to consume
> SCMI device tables. As a result, SCMI modules do not get generated module
> aliases from their id tables.
>
> Move struct scmi_device_id to mod_devicetable.h so it has a fixed layout
> visible to modpost, add the corresponding generated offsets and teach
> file2alias to emit scmi:<protocol>:<name> aliases.
>
> Use the same stable alias format for SCMI device uevents and sysfs
> modaliases. The previous string included the instance-specific device
> name, which is not useful for matching modules.
>
> Assisted-by: Codex:GPT-5.5
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
