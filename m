Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC0380FCD
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495227; cv=none; b=DSxiemCsjPXjaa8RkkVcx40bsncU8bdJNLwJg93GYjKfve3Wg4sQtchQF3cpEAeHQk0fjU4WQFgj14Z5urxSV0LQtGqrAx891NZBLb+Po7j7CHhe1vUkhZKr3rOkt5hyeWbhuTwemOXlVb2eRCdYLCuEzum+jQ60BtNlOl/x0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495227; c=relaxed/simple;
	bh=Mmc2d7zBm1iWxipjEaid3o9zeNASq3ftRZ002GwxKc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKYyvQ9tkW29rw4VpGYg7xZ291qe467vR3QH2EbroJPOSWsGZC8B0Dw6ZVzs+cz+xHjpxdvjCCWSrGLNUlv7xzGeIUWWrK434q8fgRdb3Q+uH5V+Qg/aCUVgHP0zhBO1q09cH9lJngDFg/ZlbTrzeJXlt4FOileay0qUif5lQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O2rA4Y0G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=doAsmxva; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O2rA4Y0G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="doAsmxva"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653DDl6I1755364
	for <linux-input@vger.kernel.org>; Wed, 3 Jun 2026 14:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9/bOeVPhoSAIurZMOzdi3+2T
	mq8rOt36OfI5aPW8pZ4=; b=O2rA4Y0GClKaJijcBDjsi/+AaYCF2wRbLro4nQmZ
	Vo1AqwwdwdFoxAsxIGC+8atTAssPhbhJm7AGunvScAbOkatwSUPEqmWbOTlE28rE
	6FkH++s5XGPd5IHrQrxhsON3yN8oE2atT1OUK2XFL5lHpo8TkBObRDCXbNROD3Re
	dccDSjSx2VCa4s8yx0DYBo4pNWITth4+nGfBM8jXyheEfAo6YJnr/txZ0G9Dq6OA
	hIfdJjalqu0KkCQ59YStkX2wujP00S0b/LI5pjFZ1B3s1av6cj8OnWFj1SZAvDvz
	3gqn3VRGYM2zMidFUV+iQsgNk44kSSxKl/jKO+Rxu5eP2Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejff01muj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 14:00:21 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6798c46f723so5903343137.1
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780495221; x=1781100021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/bOeVPhoSAIurZMOzdi3+2Tmq8rOt36OfI5aPW8pZ4=;
        b=doAsmxvapn/hEoGFVgmcY+iq9iW6D7yhN+jgexCgKKyXTeC62WPy0EC4kZRpgzvHYc
         fuA2aR3I3JqsdQACa2tQPkAYQ2CPZdgn+2yNJOTSGGqMXnLZwfx4QKHfPh5eywN1Gx49
         SuzAVaWHyJmaYM4DBOOWbouYTIgYhBpvioRMCCZ27gOGe7YvfZmnImItMJcP6tDjaE6/
         6U2RUZfA5l+L8b+7JhAvhSv/JoU3PIda3R3M016ZP8CSQGvr4sjHVj9pLhqFx3NXCCUY
         MBhNF78Jic+8X9ZpliTQBfPZ6yvYgxZCk29/nZr7A4O/t0VTnyG50CXaSWA67yAk5DBv
         Jvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495221; x=1781100021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/bOeVPhoSAIurZMOzdi3+2Tmq8rOt36OfI5aPW8pZ4=;
        b=P+flFiURUIMRKmEP8uXwh29ppdsWjnFqL7HYdHCsMZtUD+t4zJHko+QUqB9bpws3UT
         N7tvzIG0R/7X7jzw3r0PxpE0iFiO/geXW7WVbmS3yQdE3RUMdZMrxjbg5kU2bv9jkgk0
         Jk+y88p+iTFAyRbI/WwlaO0Da96mrFCJ4soKeWI+x8+z7eF9L5xqurshRlU1S2cMMBoO
         MyAMIEGhxAzP+YVNxtVZqZvCnvUXw/stGDvDim2DXSeS6F4Cr2Yb2qIU+jvk+QbfV6xv
         K+BWj0vHgH5eDzQzSOvcO3T+oMT/BjCWKSGg0B8Sbz6mr4ck3eFNgI2KZMLmWYur+OYE
         zgew==
X-Forwarded-Encrypted: i=1; AFNElJ8k3AtnvqtD0d3+KFtNht6sQEUP9/hqxc1uWsgw4fPBF/I6+GsWaidnRRRCPqg5LPzxMmu4xJ1FYTST1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0rMv9nKueQ95DPB+CbeOuIM9FZQSKxc1ESJw77mTYFa0omx3
	DiOM/bCfN3NSnzSCE2umYADMl6/A1+Tt/r9TAoOxtNu0btt+N74JtBx3bmJ+AgxXg/6S+UZGrUN
	hdXvdMkorxiKH+fyw2QFMPFCJgqMpeel0rVVFhlwn+R7xZJ/koyv4hV4TBLF1pyuZWg==
X-Gm-Gg: Acq92OEksStUBO9qmIdLDYSkCdaon5PLOzTFm9lh0OpLH6f/xHWrxk8p3cFCv9VJgJW
	izUoWtSKQK6IfovX1hDj7pnmHkNOafGMoOKejpDWi2yt1vcOzCl72XBF19T2gquonZHSQ6LiULn
	KJY/WJ33XCwIEUp0sy3YhyTS6lnAhIKdjKft/soECeC9WWmhvLFIOci6pRUdwGrXW4IhZ7Ul4rl
	ChVkjOnOlPLhKJpddrkfQzDHjAmcCa1xjrbmdSe+cOxjCyZybKeP1gOUz52PnCS4ugGXnqT2aNm
	at7ujcc98r+RYEZQe45jTM9e9We04q0OVRjr8Ht7FYGB8r6m39tEoL/ENkUhR++o7UvJk63EQzh
	xgs8c9iwBv8B+kBjsI34RAIUOwTw5Vn6f9hnbqtPIreObBt7ik/ggEr9PxJce4kOF9qt34VoF4D
	SE/EL7a1/e0HFC4HYMHCbX+dtPUSZ1e4i/PD36IPAwR4LEYA==
X-Received: by 2002:a05:6102:3e09:b0:6cb:d562:b96a with SMTP id ada2fe7eead31-6ec432802edmr1467058137.14.1780495221186;
        Wed, 03 Jun 2026 07:00:21 -0700 (PDT)
X-Received: by 2002:a05:6102:3e09:b0:6cb:d562:b96a with SMTP id ada2fe7eead31-6ec432802edmr1467030137.14.1780495220739;
        Wed, 03 Jun 2026 07:00:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2be038sm9721071fa.22.2026.06.03.07.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:00:19 -0700 (PDT)
Date: Wed, 3 Jun 2026 17:00:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: glymur-crd: Add FocalTech
 ft3d81 touchscreen support
Message-ID: <l3xx6wuhhrf3d3mdk5l2hag4hq3lq2br4wwbooumbq26konvyt@5aazqaoftzep>
References: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-0-3453ef577bcf@oss.qualcomm.com>
 <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-2-3453ef577bcf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-2-3453ef577bcf@oss.qualcomm.com>
X-Proofpoint-GUID: E5_43yAcIBLK43M6sNgldnWgnZi0HyL4
X-Proofpoint-ORIG-GUID: E5_43yAcIBLK43M6sNgldnWgnZi0HyL4
X-Authority-Analysis: v=2.4 cv=LYwMLDfi c=1 sm=1 tr=0 ts=6a203375 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=N8g5PzzKtf87v6poegAA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNCBTYWx0ZWRfX9nBfuaNpFPRG
 JUscKmeBe+MwWQOcRAFEH0lNnq/mz1Dq9xOplTEnLPznNDtaip1updak20D4ML6TEUcZHkq5aBN
 2RM/C3PNY+xCgB46lQraHd2I6K1ph/0mZt5DFIpszn5D+CdH/6Tm3yRmF98DlxvCzDuUe9XG2/O
 t37eNrSITEibn3g0JjIGZydQ19B/Vr6038yEM6wDMwSTZoBVrhNGuFvTZYmVf3Zv3cc9p+3SGzZ
 KUPyNOFHArnes3fgyNXRDa8dtx+PpKAvTJZh0u4Jfo/VQ+Op9GuRCpzxha8DzMWvigrFNAqzQcS
 DQ8wh7OP+KWhBmGYcb/M9U5NmtJ2IzNtI7oEAUkuMPIqKJ4M/zzc7WlKEgdt/+qzem3provJnN0
 RuRNY0h39GA3e0/Eqql+dG9c3JSBsSj5MuyMY+fMseOf0/kJY/X2Fsxy3y9s87S6NWQPFfDSwRW
 eBDbWiM3lP4FNnrbsoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030134

On Wed, Jun 03, 2026 at 08:41:20AM +0530, Pradyot Kumar Nayak wrote:
> The touchscreen module on Glymur/Mahua CRDs is different from
> the one used on Hamoa CRDs and requires the reset-gpios to be wired to
> the device. Without this in place the reset line will remain
> permanently asserted during resume leaving the device offline and causing
> all I2C transactions to fail with -ENXIO.
> 
> i2c_hid_of 3-0038: failed to change power setting.
> i2c_hid_of 3-0038: PM: dpm_run_callback():
> i2c_hid_core_pm_resume [i2c_hid] returns -6
> i2c_hid_of 3-0038: PM: failed to resume async: error -6
> 
> The touchscreen on Glymur/Mahua-CRD is a focaltech ft3d81,
> which is hardware-compatible with the ft8112.
> we have added the required change in DT.
> 
> Fixes: e6bf559f7eb9 ("arm64: dts: qcom: glymur-crd: Enable keyboard, trackpad and touchscreen")
> Signed-off-by: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
