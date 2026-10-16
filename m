Received: from outbound.pv.icloud.com (pv-2002d-snip4-2.eps.apple.com [57.103.64.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076C502577
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167465; cv=none; b=LXouClhoMEJ+O7AdmTMM42X0deO/v9MINmxf+8u37o1HY0X5YwjA5VtBKgDiVUeYBQK0tpGjxPX5ZTFQOxHzzsvC7c2WbhounfLovEZOA/V7ucBbop8okTLMNxEo6IYNnM79AzghB+EsPNomCWOFxNwX7D7SlcW/SZkM5sAEGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167465; c=relaxed/simple;
	bh=3B8aiqdinxgzAT0VpumssvkM/xdQmuYpEQ5Im0EHJVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbTVK0UmA2EvXSAgKvSUctQG+sFhARWp0js8v+UdkBdTuc2bixn5jPcbkumjV/tC64BGEZ7o2OOewi6M3iZhmSDPuLo1AxkoJ/oPT8FZ2yan41vd2CozHUMidt5Zgql07HG1WyfO9x5UsEe8FhXiFqlTsdy+oIMx+2XybnOqZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me; spf=pass smtp.mailfrom=matias.me; dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b=k80mpNdL; arc=none smtp.client-ip=57.103.64.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matias.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b="k80mpNdL"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-5 (Postfix) with ESMTPS id 1999A180100A;
	Fri, 16 Oct 2026 16:17:37 +0000 (UTC)
X-ICL-RepId: 01a14581-34a7-7e4b-8042-d837683a4627
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhAAkMDWBxBDUAdVQFLVxQEEFYBWwRyHVgMWgxERV8VGR5XUFoKRhlYCx0AUktAEwRJA01fDl4fBBdGGVUERx5dVkMbGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDgBWH1sRSlZeCBcGWxQERAFdBV0DQAhOAlsGXAFBF0kAVQ5cH0EUEFYBWwRyHVgMWgxERV8VB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matias.me; s=sig1; t=1792167459; x=1823703459; bh=3B8aiqdinxgzAT0VpumssvkM/xdQmuYpEQ5Im0EHJVk=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=k80mpNdLisjSd+1ij8YHVHpwKrtISuOCVJ72kqkJTotUDcBYcmBYgcv3lANKCV0hyAYU2WDKgS2L143UDTxr8sVv8RTQAX1ixu96VfA7EKeogVpuCt0Dvm64UrTj5Ql5wwP+IGJRMbZWAkZTLNCCabrobeDrV4RAe77l4bE+duehEcBolRrgbk02nFmAC5qKMmt+GqRDRIifSI2bMFyO+ivSsSoRZr60Zs1qwpToaUyV7X8tsH40gBlLZvjdaoTCn3qpx4DyFtQxepUg3uumb/ivjyLtS5u0YgLtrqyTic46bP1eqTFJZ8Cag6JQnfBooYDI8ZXab/FttXl723lmig==
mail-alias-created-date: 1705102286191
Received: from localhost.localdomain (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-5 (Postfix) with ESMTPSA id 482EE180101E;
	Fri, 16 Oct 2026 16:17:35 +0000 (UTC)
From: =?UTF-8?q?Mat=C3=ADas=20Mart=C3=ADnez?= <hello@matias.me>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v4] HID: ayaneo: Add AYANEO 3 detachable controller driver
Date: Fri, 16 Oct 2026 13:17:31 -0300
Message-ID: <20261016161731.13897-1-hello@matias.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925061941.75121-1-hello@matias.me>
References: <20260925061941.75121-1-hello@matias.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: L_aj4fqf-Zfi25pLJBDpiQMfVbzFS0Z4
X-Authority-Info-Out: v=2.4 cv=QtJTHFyd c=1 sm=1 tr=0 ts=6ad24e22
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=CS8cKMFXB7MW6LiegxgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NCBTYWx0ZWRfXzNAt7GR9F5ig
 8qLZTxlEm660fAHi4sx+hoz+Sj6WLbZnprt7dn7ROISvm3uitf/Kz+PFNbc7ESOPLq7rdaAOIwp
 IuHMiLEO3q9NUOJGhgzLptlrIHzrX6uuip0pGkjSlBM1Ij61+3Wlcra9d7GvOgPu2SkydK17tac
 s5WipUgGha/G0dNlU6ij+hlAjRN4Yzm8w7eXzj8DieTuRdr1VUPQLwYuc6bz+3rLgyzj7IMjiUp
 bTEAPrb7z5YYqVeNiK7T5ZZlgXfeQEvr0+vCiYwsd1hiWfksv/rd5j8OrQKt8QgmKP5LaHpnJCd
 aZ76TKxX8hICCGTT0KENTbD0hq4VcBdhioC9JiAmvoDOGqrO1B9+rJQdguvku8=
X-Proofpoint-GUID: L_aj4fqf-Zfi25pLJBDpiQMfVbzFS0Z4
X-JNJ: AAAAAAABGW6LBT02nfum/oaLVmwYxM/ieK8GDy7Axve1/9Z33wouSG3smsJ6hn9L1tUBCO64i9v+xumQLu8LSTnlQ/vsZLoC3gxmJjNj2ZIckMhvsVsjJv7hIiETDzVvNXIRx50rdSn3KPV4rUdFE+mgDNPQMYSbIkgx2lfw/m9nqKGYXd2P2U7FvdpzGwuW9UlZxb+ZuORtSNhz3SwlVdnxNbs9FG9viagG1p1H1/cjndfJBYetfjed0Ol7gMSBJhfXnQuzEmaz7BHlQB441JtcvXR2ER3LTLeWzxe/zG4Ivg6xnrBjiWyRBdVPcxQBQ36Ml0/DDfYzHBZWohTLF2VxT0tFL0B1sdBsc/I/YQSBofVs1+CgSSHhpi9w90EHI/yoGBy8oCrHtRuj8pco78xdZilzNYKENUuvgkGhQZakhS+8gF2LlTi/dy2uasjed+ntJXHUNv2tTtVolJqWaf+1YiSaPYqpPt+nYf6H8e4VtE/nYeSda4mD+6lxGUfb/WBr3/2p0hYG8vCbRH12+9FDI8SFySwJhsaqr8iPjHF66FZdL4YCn+n4U+H3mgjWv65pFfMATTn6BwSjY7CIAuUs04wdHdZeV2DjewFC2lUIg4GvxOpzWd8kFgHNPMr+ZYwMYqAxKiRq2mrRJToa/jpr6/o6/XHpsmbCt6f5tFBxM5M6zPVHsm+lds/Y6M2pjPqStarU0W4AtZ7RTKHpvIGEEPufoQUBTvzsx/VH1yTq0rDDGDKsXVaiOE3o7F+mUlvlyQ0iFrTRo0rpEE7f7at6WJr2wSFjcuRpNpYsLaiVwH5CJxFNt7NI8hx1fsylg7U+4QtgFzfTdMKRVXCvyhF8llxPNeKB7/GQmbR77Z5c1N5tYDy14GmSD4ab2oJcATA0egIdTNXwSP21omOXYOpETuQBtmbc522bgFuGYboXOx5E2yV+Q2BXxJvu1t3x9SV48KbLbqbjuDIxyN4J2JRILA8ICSS
 iUHurDtuPfVSQjTlMW0sQGknPepsCiIFA6JCP5RFDIcWiO146kiiKxawCM9ms0fEkVA9UrQYRvBixpR4qcgT7uOMKJBBWCRTQUB9fBWxNtErgavrxRyzMP0xmNN5eyR6wjOD/Wx5UM5MNP1LjCNttp8haNh3FQafLoKPcBhn9hd9nekfsNRAwAWlMKQ19BE2djB2W01auTOeNqw9YbZYA2cpQs01bx7/C65mq2Sw6MFrrtNUvkRf66FzZjJhXnVXULwz8luuUjzc5m8gFm556LIJFlRXZkgNwnXARHTNUqbSJpG7Zb/PHsh1U+pBs7P+Cp3IPDyuPHYG6sd7v5Jj/QxiRJJZu8b0DPlmd0yN+uFmJrhrtyuIIr8eG65I4g74pnEs7okU/VDId4g==

Hi Jiri, Benjamin,

Gentle ping on this one — v4 went out three weeks ago (Sep 25) and I
haven't seen any maintainer feedback yet.

I re-checked today and the patch still applies cleanly to hid.git
for-next (tip ae6927c53). Antheas, who reverse-engineered the protocol,
has followed the series across revisions and was happy with the final
shape. The driver has also been running in the OpenGamingCollective and
Bazzite kernels since late September with no regressions reported.

Is there anything blocking it, or anything you'd like changed? Happy to
respin if needed.

Thanks,
Matías
