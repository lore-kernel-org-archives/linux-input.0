Received: from sonic314-22.consmr.mail.ne1.yahoo.com (sonic314-22.consmr.mail.ne1.yahoo.com [66.163.189.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74312F3C37
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702131; cv=none; b=GYyNXzzHceIFAizPmVmYi3K5vCw9LtOcLVoxZZp1qkg/vfsos2g8trixyaoZNz7WKmWn7zhJkM6tDttbPti8Af6+CV2ez3rNThdvqEW6CQmyD7KPCO+u6+4SQzvmiop6eqq1k3OrSR7rJvmMatg4zZ4gmjTjaVlt1krGKRxFHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702131; c=relaxed/simple;
	bh=7BjHk5yh7gbYPqO9pW+hVuB5HwvWKfVKmq8jqOFnaVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fo2YP8+9KRzRWTg1S6q4Uper7Kv1XyK9CV1fmLsb7qCOFiNgc7lFatGNbXptSjgqrX6ZkJqQWuEFfq4d1CznmtlVV3G9ks810iwNftmIy0f3w2ED6g0Zj9KEgaAq3UopycBPxDraHr6NiGi0KBmti4i2tEgJH1ggMr59YZ1G0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=U6NIxzj2; arc=none smtp.client-ip=66.163.189.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U6NIxzj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784702128; bh=VQyVnHp3Ux5wPVB1lrUwQl1e/ZaC9coK9MdO1QfGxA0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=U6NIxzj2Qtx2vdHZ57tIW7GwO47vuRNpVlZxnDuO0rwpMc2UpYWDlqR1LioXUi8VMWm5cI4pYMC1VAl7jS88x2iD6bHkTK0K8PkPLpIRhcvVKg1THLuy4J4Kn8qagCADJ4xDao/cnkpO3DQEEzzuO8DP3G/aPJaiH6xYc027RQGVvWBnrFzXTKAJo0kWKMQHK4GJeesL4ghOuowUPihULCIEnOUnWd2OUijpkezhstwN6R4k97fbwC0ctNp3HTv7stwn4HVMGW3nQX2SAks1H7jiWhhrV7zOiOxSjNuHbPRHcg12rfHyxkwulU6O6U88OjQl5KmwOcyYUrlqif2o2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784702128; bh=f3MBAA0SkvTry0RuWA1+LDofTq+0lMrzG3iolO/Qmtv=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Dfz0dmLfw7zYpofGTPRbqyifC6fIkvwVnSb7GCnNaPEackVIO2TkEClz3txnqhoizXafzt53zrxjx3jD4q2rkelT4W0Kxq7YQn2CzWZ1IBtCSohE7IY4+jskNNAAEX8hRO6NQE8+g2fRT8Kohdpcjgjbraasb2PhYBxubeWtiphV6420Wi+2YT0sYbcTahYkvP/PfFTLudg4NqYpG3NEYHJFo006N/shE64VVoK8Ui5q2HsyNGK0fd7QpUQRDLOu7sA41cgQH0bEg7bXyOVE9EQvJSrBlYTY6r1A38O2Re6IwVLQE3sAWonUaMWPDir8RL/4knv6RryhG2TesZ+FqQ==
X-YMail-OSG: DGx27nIVM1kyFsJopvjdUR9LImpVgk9_wNv1PRchaeGHampzCJzskCQkvp9OC7z
 NDpeIKTjvo8j1j7FBx.ZRKDESIG2MhTC2N7ImI_oRXiVoDCd9r4gLEVuv.caij2UfJWqgTPZY1gy
 dquIdwY53bqg7vkEeFeDrELAKUGYTrnVIckOU_qObvUOCJ6.XO.S30zGj4QSVgEA4w3dB7Pkmvg.
 Q53ZejPVVadrx7DaULiBRVvavh.T_28_XUIi3_PxJkmISdC4k6ZRgxx6iPl5QEElfkEB1LKqeECL
 ..U2vfefCYxE1fCP2DKtUbZKe3ZrEZjmPDs7qHW51Q25KWxRoeam5Mfn.llfHvddpMjrfxhpFJV8
 irSsBfrv4LMCpzgbGorL8g4aRNyMwb9pQL7sli.xT4gEhPEE6Y5Qz0s6z2gVSz276ABUeZJSFZ_C
 jOenmcpuT6E99gx0dZPfbmUDzJrlRg2JYxoLv8et8jJ3J4.nxVxQeR2_g4VNFk4wbjZLFeSrh7Tf
 g7vMBoDrjmz7pc5x7aJRPdPtnaPhbJIi82ERUb.IJ2uPLA.hP2jAatDXjuUfUPuqCUfpoopC5xcP
 eMXglhjnSz9_MEq7OB7ej59wKkeGrIMRUOVlQv0VKfPxPgyVVmSPmgqJTLGDvKNzA1YWwbzTzdKT
 nPRDbpn4Ir1flavcG6neumvIm7qORAfcBg7YapOr77gqvN4KkclzULRyhW0YmGkmhXy4IF6mSimG
 _UBhF3q6oxQKNx__Uo6aLeT5wH2O0fWBx58ThErLXxK8xhSDOINKvIujlMmAPHMv8qPndkLG6Sq0
 mHgulfdwwYUYib2QJNT8NB1ZrQ3UZEAAHm4f72xAyJ5y5PTCnKRBUY3yQR50quOmRPSDsP_owXN1
 gm2FCbkp2nJoWMdnQ2UEqR58UCnwdvh8H9j74TPZQ3N.LmXTOaiUpsNkDAhZJfR592ZkDaw8XtNt
 b0JFPYOVvmJPnaJX64KRV0m32U1wv8U8kYy_eoUIskyWNzgwEO0K96hMbx.Glo4IdzLLv.HR2sHe
 e9eMbpI0Rgdv0rDI7pKw.hyZWOz2JsCrXHp64ajfqrmR7qMfjokH_5FYx0swKiV5vtVZ804wx98a
 B0uqgt1h1DrxRaiDE9pMuXa2u3jEz3QAkhZYTGWNyNOGbO.cUaPwH.EEtkAX5hV7i0Akc0tnurc1
 irIo.FZAit5h6iewvKZUSuqxc6Or9sqQuOSVin62ZZy0uYt3rvgw4Sqvchnx1Jdpi_RPkRjQULj9
 mCoIf76GsJJ4i1rHu78nwk2L7XqbA0aIZmh9q6ngT8q.0C9ZHASDHK_UcjOvqBL52PZ7oKOzAuDH
 7nV.TPmb2u51sdffUD5PxxeX6Fh7_UH8xhbE4CzqW2cgP0p0ZOtTM0Aj_A4lfQcvzL5xX.JvGlaS
 lYmMAjzEOed1zePNipYADrW8AZI7EDdm.edQ0nGwb1BII_FdfIaAf5xXFgs8B00ClZXqYYys0hQ.
 5pC_56zbvBMXShk0t7TzXE4OnEwxO96eT3ilV1DGiswCvLkMtQZyV2NSMKby_c69XAnYf3IWUM.F
 6qhFGeZYZsCMOuSWVcT6WjdcdnoCynee.Zs5jRQFg2u2poX2k1RD3Rqgwu5_faWxA_yigqQw7tkq
 S5vSfZ19yiOEEcsu8EDCrh43dSIMcTN5VnefR9bUADwd6VnPejIOYQ8xEddU2yTvxeiqt9wL.N9F
 7FyPvSgu2f_ibCYPKUsTYFsHUaSEgkto0jk28ATjf1R60VRmjWq1Tkh4xSdwtUzGgCcZxjHB7LJW
 cFrUvoj94i7yLVbcOYRZ_upvDjc0DSByCAQoSa.kAhEzJ6FSU8rjRh3oW_0rViMtvo79JFH2tqn9
 W.l_q1fXtUyP5fO_Zai9hdUwopIrmvBgx46_C7pA1J5Ant1mpglKjwoT9dw1dM_Cnuqs1dQn396u
 1.PKdmfdXzpxzvu3uN_ADRlPO.mTxmLp6UgfRB.DxecNQ5zBzT2SzhWuUaR1rPYtvjl9yi9sEA8x
 uWkEJbtk5kllIc5F48uXXvtZwZotfpR24Kkqoxw.LTTlJ.uwQKXRUeETqlO1TwNBWCRXyLKbqjE1
 .iVP_A2We9_KZK05ugpfmsrthckWhR0Nvj5EHu7aCqDB2cA9b6PX6wE6tnANXGDMbAr3vtddx9lU
 HQHBlOB.3wilWb4yQyxgkGgR0ERNNcb4kkZwteKXw3eswXEtGNCQpkLroFpYDQuY3rwukOkQHvwA
 gzal3F0XfyQajyQKBT01.ULcYZPVOUJVZzD8pzl0zudtPMaKNZA--
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: 61f8bc7f-ed9b-4ab1-a3f0-dfb143fda4c0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Jul 2026 06:35:28 +0000
Received: by hermes--production-ir2-7b48fcd765-kss9d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b0729b69c6d9ecd2f1d18cd316ff5dfc;
          Wed, 22 Jul 2026 06:25:12 +0000 (UTC)
Message-ID: <8bb2a72b-a1cd-4504-b96b-63f8b447417e@yahoo.com>
Date: Wed, 22 Jul 2026 08:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: asus: add new Asus EC hid device for keyboard
 backlight and FN HotKeys
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20251221-add-support-for-the-asus-hid-ec-v1-1-35d7d70fbbfc@yahoo.com>
 <9fc25f84-b8b1-4ffa-a79e-ff95020ec45f@yahoo.com>
 <5o7r0493-19r1-208p-404q-n0nq453170q6@xreary.bet>
Content-Language: en-US
From: Alexandru Serdeliuc <serdeliuk@yahoo.com>
In-Reply-To: <5o7r0493-19r1-208p-404q-n0nq453170q6@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26180 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Jiri,

Thanks for the feedback! No problem at all, December is always a busy
time of year, and there was no rush on this anyway.

I am going to test integrating the logic into hid-asus locally first on
the Zenbook A14 to confirm everything builds and functions properly on
this platform (aarch64).

Once I verify that it works as expected, I will report back and send
over a v2 patch series.

Thanks,
Alexandru



On 7/1/26 16:12, Jiri Kosina wrote:
> On Tue, 30 Jun 2026, Alexandru Serdeliuc wrote:
> 
>> Hi Jiri, Benjamin,
>>
>> Enquiring if anyone has had a chance to look over this patch series from
>> December?
>>
>> To provide a bit of architectural context, this is a 100% pure HID client
>> driver.
>>
>> This laptop (Asus Zenbook A14 UX3407QA) runs on the Qualcomm ARM64 Snapdragon
>> platform.
>>
>> Because it is an ARM device, it does not use traditional legacy x86 ACPI/WMI
>> code.
>>
>> Instead, the Fn hotkeys and keyboard backlight controls are routed completely
>> through standard vendor-specific HID reports (using Report ID 0x5A) over the
>> existing I2C-HID transport layer.
>>
>> It requires absolutely zero Device Tree modifications or external platform
>> subsystem hooks to bind or function.
>>
>> The driver matches strictly on Vendor/Product ID (0x0B05 / 0x0220) passed
>> directly through the core HID subsystem.
>>
>> I would highly appreciate any architectural feedback or a quick review!
> 
> Hi Alexandru,
> 
> first - sorry for not having handled this, it somehow fell in between
> cracks.
> 
> I have just one question -- wouldn't it be better to have this device
> handled as part of generic hid-asus driver? Giving too many Kconfig
> configurations for every specific model feels a little bit too
> overwhelming.
> 
> (yes, we'd need to have hid-asus depend on I2C ... I don't think that's a
> big issue).
> 
> Thanks, and sorry again,
> 

