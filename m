Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795517705;
	b=UIahLZvspAywpeAf+0h5EFxJl9DeWHOv0TN7J0zTz+QoMxz0P1QkBt8HFOt83K3FyPzt
	 wuLsX4YG5VTp1lG5IbO1HZwE++qDxhx+SQRV8URG0gfi2X5caPjUvLss4MiGFMec3avMn
	 F3JM17dmBnVOL3UK0/YjCtNHIdWT01T+3bFba6DnSlCxRh7LbD0DvbPaih56IxXUmb7R8
	 9cGeyh6x3RczjFNvQz6CCIeRkfcdZS8T0NvepTvli4QN691p+y9/FmQQdvVFa44TbH+d9
	 63ar4s1kxqlC/QxcOtTgRJtaB0GzAw1utBbpasBnJp1DtlBIDYdT7PRuKJ9Q1WrtCUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517705;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=INt5KuJe5Ta76AN2NV01s5cGe8cgwCgb07Tt435XZmU=;
	b=Db3hDQTsmSLMA+XZikpdIHjaY6r9iGd4KbiTdOwAEqIfoFulOIduIwh6LHKnv4D723ED
	 DhYNrxc1jlM9E+tWJvzgdGGPO11vNfhXL0GCPW6mXghlbEd/bDK2+Ao/Z9xix3jKaHIBC
	 5hPlowaXn4j2RgrpsXIl74ManfLh+c6UQC3U8ediIp2OElFp/Yy/s4KLKkN9h0M0Gs/dE
	 MVGzTdIbfR4R8sQg6UaobrFNZ3Ky3Jn+Cm3Y69PBMoNq0PAsUaN6l8MQEX+2CnAcYFE3R
	 3GXs8kYSVR4hGbUNFSqwYi6wzmrDb90zTuyV/bYYoWIiTThkxjy1eChLsqI43Bw+4HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=macq.eu;
	spf=pass smtp.mailfrom=macqel.be;
	dkim=pass header.d=macq.eu header.i=@macq.eu header.a=rsa-sha256 header.s=selector1 header.b=u48705VK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.134
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023134.outbound.protection.outlook.com [40.107.162.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D6606A32A;
	Tue, 24 Nov 2026 10:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B72D6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=macq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macqel.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=macq.eu header.i=@macq.eu header.a=rsa-sha256 header.s=selector1 header.b=u48705VK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InkIkP6BOUoF4JjJ7oaB245tox0HYHBQCFSHvnxrdV7HGu07sRyagz/jpa8w1CE93RwGUFqdlc30r5pd2A6ofWABUCZTQA5nWMysxX6Qv0ffsnjMZ+u1x3T2NaS7WrWGEJNXJFDMf6UIcifML1DwZTBNpWvqd30Xv5MUMRqUCk0wOpf+eKcE8CrX36o2JijMDIDAIZTet/0RsahV/XXMf1elw78jW052k14eP2Igbta2v2knl87BxxiK07m9TypF3eBPy4y2sje9I3h7mbW8y6raFXZGPW16CJq0MNZRYGKOqlisT0klxryFJnB0vnKDxmG2b9ViGAqXN1UD/iqzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INt5KuJe5Ta76AN2NV01s5cGe8cgwCgb07Tt435XZmU=;
 b=xhddG6vU7HzcVDkswmDsFBaZ1Qjs5k+D2aIuhk7yQWzq/A+kmT8kYWM/7xh4WytfD0fT459fy0Xnj8Dk5bGDsWl12tpGE/sPWJuGgoayNS8rlc6krE+emlLNecvOW2pAyAlpzcqmmvcRE6CzcnbtUJFpYXWQvOQ+32wM+e9e/T+CJ/aatlkTFt26EpYzFB+SBsyF/SKSke0Zb6vElYmi3TD4TF5uhLXLhcZY3eUE1msMiKdbeeKEh6lhymIAaDaLFsrsusKSwmpGlXUXwXAOcyrM2e2ebVP4VimdDBph4mdAObm5c2rc4aJ/PsP22usFRNrWn7uQIqEMb0NrF8+X6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.183.173.212) smtp.rcpttodomain=0x0f.com smtp.mailfrom=macqel.be;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=macq.eu; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INt5KuJe5Ta76AN2NV01s5cGe8cgwCgb07Tt435XZmU=;
 b=u48705VKYRiRGCUjcS4wb1H4QR8FsumdI6dd5+ZvWp1goMDWRPYtZLek5yJ304TZ4aSLkv0YDZrbxNH0YzUUXfCwRV4DEBb8FWEVMc+zAvgPV6+sncW8ceapmchOFsqHwJjnPrXM0lizLodNnaOCpX1sUyhxi1omRHDz0dwbxM58VpAYXTRzATrlRCGLjnZVcX+N8kNOIML35mTMeUNTpZXzMlLNxDgLjzDpWtLaaASlzozIxHt+h59cGECFm+mf0oQmowgD7CbN9A2FQsBq+CsUpuwLV2tGrWzf2IriGqae03vWTrwwuz9uPIuorMjU93FLdnpSlHg7I/SoWUv19Q==
Received: from VIVP296CA0110.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:355::13)
 by DU2PR05MB8886.eurprd05.prod.outlook.com (2603:10a6:10:2d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 10:55:01 +0000
Received: from MI3PEPF00008493.eurprd03.prod.outlook.com
 (2603:10a6:800:355:cafe::32) by VIVP296CA0110.outlook.office365.com
 (2603:10a6:800:355::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 10:55:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 91.183.173.212) smtp.mailfrom=macqel.be; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=macq.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 macqel.be discourages use of 91.183.173.212 as permitted sender)
Received: from frolo.macqel.be (91.183.173.212) by
 MI3PEPF00008493.mail.protection.outlook.com (10.167.240.154) with Microsoft
 SMTP Server id 15.21.639.5 via Frontend Transport; Tue, 24 Nov 2026 10:55:00
 +0000
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 4EAF8DF00C8; Tue, 24 Nov 2026 11:54:59 +0100 (CET)
Date: Tue, 24 Nov 2026 11:55:00 +0100
From: Philippe De Muyter <philippe.demuyter@macq.eu>
To: Daniel Palmer <daniel@0x0f.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: amimouse - Fix the buttons
Message-ID: <20261124105500.GA20772@frolo.corp.macq.eu>
References: <20261124100604.2380938-1-daniel@0x0f.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124100604.2380938-1-daniel@0x0f.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008493:EE_|DU2PR05MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: f7cd46ef-966f-4802-981e-08df4a196313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|14776008|75936004;
X-Microsoft-Antispam-Message-Info:
	QT88JIJQrp0mXCJ6/d5uh54lq9T0R8YvN/GMxeLUE/n+GKLJc2lUYWR9MdUZC2mEjHJtc7bvYlr+U86XozyAl8LtVvYtfqcKl+1tUlDtAdVgCorLjYi50FMeXTOZMW2m/S00q/Tg4a3Y64H7KGqOLngIzaZkGPPTi3FaIZ2xV2oTkCZloXVsQadV1mvCHLBJa+vj2+TXWfkH48UPKzRD1AKX3FQilkDajuJj6jCQEszzPaRqNEC7nefB+hImxA4MVcFxxpRcsOUvneAl3r/ajZDQY6IXZyFZEjEGyokoAq7bB3oUQYid9a4+FQOO5DHOVsFANwts0dO0hM86pwWJ+aVQNT/rJ4l3vTvteL9NL7qv+2I3KbWjIfpHq8EJpR8ekYuJAiR7DDI7ZqKLkpSgFjE6OhTX5rU7kC5tfDgaYC0VhM7T1rFklXuD7Hdy0FuVAZ8FLYlBvOfLkDwKlo952ysuXjHielJTnDwSn0DTf5gVTdVFQSrXoq3HgEjq5Cr6chH16uUbjrZaXarWhvMq538BkHxg7sJI6NaZm/mFTL2GO84X1T3g3INccP/DSpuiuEcKd/9OxcFE1uUsY0/VCFMHtVPwiw8l2jOQhJUmN8X1DG7R6JuJHuk9PvS9IpIxoiTV1xrrWaRn9k8K+FK+XC9O2tcKzkKwbxYjmJBeO5f4KzBodtkGEUmcDshFfCvZx1NP8eU+k13N602yOk/Fbek23A5dO+ecim99Enyzhb1QAp6qAiTWt3swM+LAz2rIY7Dlk51E6ZlTeLEMUh8LZw==
X-Forefront-Antispam-Report:
	CIP:91.183.173.212;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:frolo.macqel.be;PTR:212.173-183-91.adsl-static.isp.belgacom.be;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(14776008)(75936004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HaKDdGTqjD6K3rY7SAVs6b9HTyIjJiztW/4VdjuSL97xDSVEn7LngRpor+yVvxQIBwsUSaOKYJAfGMkJuC3Ci0T7L3128ZlFSv+Ys95mYhSkmHgOMmqP5ul5HkaxHTiuwidtb6JOvM2vYeFxx3Z/siUM3VPnEeQgkBG0TKv4ynIBTuzDf//Xxc0YtR6LNiPHuOZL+qfRg419qLOHknrHJaKokZcvkqYGpZRus3h77S8PgyvAa7yoShZGf7q5M02ZoB9+tb//OKZiyUcqyeRsJ8Yb2N3ymK+QWbEBfjRND54e+p/D44TDQWDAfVFG/kiUX/ZQswwXN+920VgSJPj0fLklmcf2EAn07deAati92Ptrs3qN7oJN4wit+e1jlvdoRn6ei7DeTSZx/MgHdYwOD2NvyEk8bDw/WLUHMFtFXcKPlWSk9i3EsVzjPldq8Mvv
X-OriginatorOrg: macq.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 10:55:00.5888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cd46ef-966f-4802-981e-08df4a196313
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5541087b-384c-4066-992a-42aa5fe171eb;Ip=[91.183.173.212];Helo=[frolo.macqel.be]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008493.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR05MB8886

Hello Daniel,

On Tue, Nov 24, 2026 at 07:06:04PM +0900, Daniel Palmer wrote:
> On the Amiga the left button is connected to CIAAPRA bit 6 (/FIR0)
> and the middle and right ones are POTINP (called potgor in the code)
> bits 8 (DATLX) and 10 (DATLY), all of these are active low according
> to the "Amiga Hardware Reference Manual (3rd edition)":

Try to put the word 'mouse' in the prevous sentence.  I had to read
the description twice to understand what you're talking about.

Best

Philippe (not a amiga user)
