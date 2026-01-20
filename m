Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727DF34886F
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950311; cv=none; b=sr5ePdlu1OFwpdAvmoIj24Hzbyl7jw1ZDUgemnx0FhzzBV4w16Y7bAQm75jA7SHUleJNtDhDCyMgX5Sgo3tpMQYU5SUnKLRRQ2Fl5cbfYs4BtyJd/tZC012ek8qS2FMy0WYwJxhajsS0jpUU+7PHwovtUjLTbwk6wktUOgMJWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950311; c=relaxed/simple;
	bh=1j0Q7pzf7hRqlVAsUJvrX/tEEQPL7qnr4VVR8jMUNds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Srlfg2JJQe1kOcrWQIDT9A16/4zKiyphtO9CqGhTqBAp1CBXgAMOHGXo7qn2dukxqzNH9UyTrC81AoN38qJ7b/QLi0uM+f2RH3a+EeeT8MSnK/xNZ+rzbe5J8G4GCPmDbrm6CitIupCNiLhpNUdeDHdeHSS11Vi88j0cF5bdXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o1jl8yGi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YmIdj96+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o1jl8yGi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YmIdj96+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KL0HXt1530571
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 23:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GX80EvWIrKsY9lpmTcbAZWS9
	rKhCDtXMk6nX0x3Jqa4=; b=o1jl8yGiCVqVRV+QVz0wLA7JlQUIVvqJ9dafY23/
	raqoYDeVFq5SPb/r3Q4LGOLkP1LVn+ctg6Znx3RJYRe3COBikG/P+gDSzgMgSd/J
	SCTa1klEBv1dG/LyX9LuKDv5SKD+tGCQn3mRmEFJjy39f01mNkelrasRV4/p1NyV
	eO80qasxDBAm2qJLDsYhilbb3MWqsD+qcWJJS4spSRO0VQt5OCwzzBFbi3EowPzD
	4Xr2teINTn50uxUrjPsjCyofeN2EsJn0rBAWMEOogesSZWvxLZMc/WpT5J4Uzo9q
	tyQJA2BwmoKK04Dbl79z/SfMeHE+EON7JQQ+u7WHKxVVuQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bth83gbev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 23:05:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a341ac9fso189133785a.3
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 15:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768950307; x=1769555107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GX80EvWIrKsY9lpmTcbAZWS9rKhCDtXMk6nX0x3Jqa4=;
        b=YmIdj96+rKMzR0p7CBf6yeKlm2FdRgHWIPXxO0UJ+gssklPhh0Ik+qhDE9KzcgS1s2
         jZQJby5N6R99FyMAFQ7D3+T18nmjNh5hfGuF9NVqeUp8aV8iES5iMmmQju9b3lFfuTNR
         6Lo641Sy7mGJcFQWiRYUOlf+lBUL6bEPYqEwhvYI5KkLXPKKPssH8yL+AbSyGz1IHMo4
         glEuqgQ7Pfa601kTT6VnHg1BryciI4RzdarM6we4VUsByZw6JfHrMr39nCOE8IbKoJb4
         xahvyzLdHddkB0NJfJo43S84Sz3p/wKlbPCwiQSv4IIIdeqlDfhYZEkpymQBiPV6W23D
         iuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768950307; x=1769555107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX80EvWIrKsY9lpmTcbAZWS9rKhCDtXMk6nX0x3Jqa4=;
        b=TuXl8PCSvogfAU6a/iMw8casbxAeE+aR3lfavZ9MyMXBNnx0B2VYRF4+CtKGntwZEO
         RXRGwCqOFJI/hTtTmWohd6nR1G51i4MxDoSkhSIw3l6D3fADbWO3TSKFRZXNGWs2KHjy
         /46qei3/RGepudpAlt32cg7/kBXAZseklDTOQd8n2fr2p0Kz/LGu/x1EGyKWblqbXIlY
         oAaIwoVSjk317ZucWDdBRXHSrE1MzKoF62j6y9ucQITZkr8YQC5BSbCeEPPOQ74C54fo
         PowCEgKYVsgYmOVF7deCHaMAkw4PynD/5QrV/kHQCFO7GEaTeJhd50UgnXj3w73XEkL5
         XxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbctjzMVjLuDrlkk+sOH4R2255UQF7HZWmPVB2oia3havwTHPyeg7O0wVfLQxevmYbQ0Oeq+Djze7hKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7c9HhndKHmibLUMI2FYtk2IJeLFJNzv92Cw8v57mCMmB3B8VZ
	QoD2/E2aGnGsvYQ+PFQkTEduPacC2BeUN6v/7TpF4h9e9LaCF7rFxZUGN1puycr6/rRSv96g0+k
	47f6Bngkaf6xDxIg6WbGPfRvJo2ll6tGpLFRzRXMjY9qVckBVUxqc3hJS5hcHgTY7/w==
X-Gm-Gg: AY/fxX4l369cOu8R+9XuurUWpHjoxtht2PIeisyzGDBqhphzwgG45nzPQblWeEonl/+
	mhzujwOlh+8PyUgM9V3LQQxrDfYPrJHtPdK6NyG1orxTsbW6HDcg/6+3XaZ216LCSZ8Xq4RVxyj
	Vz5VxA5srA30V+LNtEAqumoMnEyG9y4ZPtji6azaBSbroty5G/uviJJB0VQUdTrJXJO9SvLsfiL
	pXwCcpSAakVLHbjE39zca3UJhTjM+jBdIwbzu5+pR216oel23e+QHTYf0WrG2OTSxHO1Plu9x+G
	1ouAqJyra9+8h+SaovMhjwUj/JyKhMSTVUkCEs5x7UBs+RpOhHVIN84Kf5L8UNW6JQ3MKu+9aar
	LyKFOXDirV08I/pF8P6LBGkTVUcPGfrguo52r66qinUQad5zVOIQPLVS/UmvDS9wtX30DbjvSVn
	dT9CYis2PM2krXs6axA1fVMtY=
X-Received: by 2002:a05:620a:708a:b0:8b2:d56a:f2f3 with SMTP id af79cd13be357-8c6cce504d4mr450312085a.87.1768950307569;
        Tue, 20 Jan 2026 15:05:07 -0800 (PST)
X-Received: by 2002:a05:620a:708a:b0:8b2:d56a:f2f3 with SMTP id af79cd13be357-8c6cce504d4mr450307985a.87.1768950307087;
        Tue, 20 Jan 2026 15:05:07 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384dbe6c1sm42390371fa.22.2026.01.20.15.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 15:05:06 -0800 (PST)
Date: Wed, 21 Jan 2026 01:05:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: milos-fairphone-fp6: Add Hall Effect
 sensor
Message-ID: <wpjvuclvpjft7y2rlrmfgszkzmc5vvmohif3etqrtvymxjjyjk@h2dujh5egdvd>
References: <20260116-fp6-hall-sensor-v1-1-69275c6bd809@fairphone.com>
 <3a17f2e5-0724-4d70-bd22-1e612142b3e8@oss.qualcomm.com>
 <DFSOPXFSOUY2.2Z6XCLCD796Q@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFSOPXFSOUY2.2Z6XCLCD796Q@fairphone.com>
X-Proofpoint-GUID: bTLG9l0Y2mrJjgk8oB3luoMTNIKoydZt
X-Authority-Analysis: v=2.4 cv=TeSbdBQh c=1 sm=1 tr=0 ts=69700a24 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=5kQVAYz2r87DXKKq-r4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE5MSBTYWx0ZWRfXxavVd7YMIWew
 PSb47dVVXTrg/uXS1N6oK2VTsrSRjPeBQSPCq6Vyh7+QxpqR5ExV86H1eXqwFh9WBkQihTm64lC
 gBKQZLi47vSjP6eQ1lxgvxNq8VwFHU6zaG/KfreGvHQskPsY+SwUGDEes9R6Z5GIKJGMBkwluS5
 3toiK2WvXdkCd4gUMZNrGQJHQTjUaWc7KiJXxSm0gwaFv6tMVLoue+OjEXuDTFKTrwF2rTTGy+Q
 +lWwe+F8Fwbuz8sCC0EZUfSi0eX/v6qd3huHffaMY9y+Hy6rHaQPfIH4lnLp6RtY5rvMbesRQKW
 M5WYAR5zOXJl3fR5Dw5zBc/Sm8LMXY7lWtDxglyzmf4NARKE8nlpcKnrb5U67y5YGSv24mVTwuc
 w3SNqngN44psK/38TFA7ufIcOa+xP9xMPJn2yHT7GF9PFsSC/SIDQQtDlM+8OR2RXRySjWR3wlD
 yBwgq2AZb8GUH77iIow==
X-Proofpoint-ORIG-GUID: bTLG9l0Y2mrJjgk8oB3luoMTNIKoydZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200191

On Mon, Jan 19, 2026 at 04:52:23PM +0100, Luca Weiss wrote:
> On Mon Jan 19, 2026 at 3:41 PM CET, Konrad Dybcio wrote:
> > On 1/16/26 3:22 PM, Luca Weiss wrote:
> >> Add a node for the Hall Effect sensor, used to detect whether the Flip
> >> Cover is closed or not.
> >> 
> >> The sensor is powered through vreg_l10b, so let's put a
> >> regulator-always-on on that to make sure the sensor gets power.
> >
> > Is there anything else on L10B? Can we turn it off if the hall sensor
> > is e.g. user-disabled?
> 
> It's the voltage source for pull-up of sensor I2C bus (so
> ADSP-managed?), DVDD for amplifiers and VDD for a most sensors like
> the gyro.
> 
> So realistically, it'll probably be (nearly) always on anyways. And I
> don't want to shave another yak by adding vdd support to gpio-keys...

Why? If it is exactly what happens on the board: the device producing
GPIO events _is_ powered via a vdd. Added Input maintainer / list to cc.

> 
> Regards
> Luca
> 
> >
> > Konrad
> >
> >> 
> >> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >> 
> >> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> >> index 7629ceddde2a..98b3fc654206 100644
> >> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> >> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> >> @@ -32,6 +32,16 @@ gpio-keys {
> >>  		pinctrl-0 = <&volume_up_default>;
> >>  		pinctrl-names = "default";
> >>  
> >> +		/* Powered by the always-on vreg_l10b */
> >> +		event-hall-sensor {
> >> +			label = "Hall Effect Sensor";
> >> +			gpios = <&tlmm 70 GPIO_ACTIVE_LOW>;
> >> +			linux,input-type = <EV_SW>;
> >> +			linux,code = <SW_LID>;
> >> +			linux,can-disable;
> >> +			wakeup-source;
> >> +		};
> >> +
> >>  		key-volume-up {
> >>  			label = "Volume Up";
> >>  			gpios = <&pm7550_gpios 6 GPIO_ACTIVE_LOW>;
> >> @@ -316,6 +326,8 @@ vreg_l10b: ldo10 {
> >>  			regulator-min-microvolt = <1800000>;
> >>  			regulator-max-microvolt = <1800000>;
> >>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> >> +			/* Hall sensor VDD */
> >> +			regulator-always-on;
> >>  		};
> >>  
> >>  		vreg_l11b: ldo11 {
> >> 
> >> ---
> >> base-commit: ef1c7b875741bef0ff37ae8ab8a9aaf407dc141c
> >> change-id: 20260116-fp6-hall-sensor-1049f2f872ac
> >> 
> >> Best regards,
> 

-- 
With best wishes
Dmitry
