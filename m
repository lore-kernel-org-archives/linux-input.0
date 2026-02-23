Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01F3385A3
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818879; cv=none; b=UK0305lFfogSsZySyvOGp5tr9I6L7zBKUqdpLPjCgYW/s3nbl4XNwv8zt+1KnwkJ6Ye7mXlvv5BLh6mPNKYcFjfQklHqZuwtbnOCTtQ1dbx1CgjX61IF53J3vK4mKJoNc0pOg3FYqSU+WFDTHATTFmgg+qafyjZ7awFv+BC5MA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818879; c=relaxed/simple;
	bh=DL/O85xB+imBUpPglQSS6Wj5oesIn23PeIjvILrTVaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puTQdZJRvX22vgY9ahP+sn2eTNGBlXke8i1IKw6/SS/QIWOv7RwRvNZox4SiJuhT2w020Tj3V50OlJ9O2d914B4Z3PFPOBJqVuCDBZKFnqaDyyWWP81s3l+jaAinv61t+aeSYmuWhFPcTqnN/wv+lX5n4Q8EEbctCJisJU8BuLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPWvVOgO; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPWvVOgO"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1271195d2a7so4051440c88.0
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 19:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818877; x=1772423677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qPPGc8+eZXSIn5RBSIe71t3+20AlyQ271j9hhpmbm8=;
        b=GPWvVOgO2npbLaAwuD7ldosPCMJJoEKVACmnMTLGPjqYIdPFo5uU+pOBNM331M4eVm
         8rrtn+hjfdg5AxGswyB+M3q6MPAaPwKQoLam0oJnBjFwuJivUOoaGv3Z5swBOQCQguEF
         GdH8BcFtdWRWtzn5P7Yya/vpfRRzNMliTJiesVVDpx5nMP6oLg9HQlcAW1MZNV/9LrJl
         BWGaGLCJMATXEmnS7J4H/EY9ddmnM5NwbNfOVgtGw0HF/+z/VdfmoUe2Knn3U0WyZs0D
         QtVMbil9wgCPNORBaDt/45axydKg6xejB113RbC2N0ts7w2b5EmL0p3oVDulp/JivTh6
         VDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818877; x=1772423677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qPPGc8+eZXSIn5RBSIe71t3+20AlyQ271j9hhpmbm8=;
        b=VSZ5NS9gLuWYfki2oV4SVx0jlY98xKRsMx0ECxr/w5yfKCVLqBw3phn8oASRVIISgb
         b1qcISh6k7G21mNvvSqmchku0s/V3QJpQRFBQ+IOQfxbLm3dd3nYd6bEx1m+w+iQSLk+
         dtSkcibVL6ds44xeeoUrtvrpVC/soDfDf9q/5IomngrY0V1ImQoaqRBn6QWypoyQFYQe
         2WNbHogDiHJFZ4c4XOa9ZpH/ULL806X90UM28j5dXzwsYI5arCSbgyG12H5VY0aaEQcc
         pdwQZQK8iOzo/pgX1fVQOycAlTM2EcZfJqtB+dBPJNvLDFZD7oAA2x06Ok0VDUON933J
         cQhA==
X-Forwarded-Encrypted: i=1; AJvYcCUMHvDi2ToFaOYiRRwCnY9jAH9XTLKWI3tCaEAg13KGeE4w0H2dijsu8qO6xpYw81XAGSLO4Pn3re1hgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoM8KPzpipNMYs5p/imMP1aETjGLUSxNA7sIcKf+lWtlawGiRm
	o+586ME19YYNtuVvY3ViGuy8/09/BGZcAshcdBIpUdcau3wzV8meM8v5
X-Gm-Gg: ATEYQzyt5kHslLEctS/eYCWY6V+hR3TaWif2W3Erm4PL1VhAQvhvdYbKU6RwTYJWWHl
	zJOR22T6yKbMjVKZ0q5LEGUnC8q3GWGPi9nPsCUio556NGh0Mlk7FMrWrzg74uyciLVSv69AB9G
	V8XB7DPa2VGhkA+KhlmLCnfMcxWkdyCQzk72GEkRZCEF6g7SahhSe8pWcCqlqpds1ZfGJInTmTE
	appDY74XI7AhuwGjqtsRqQtF9FidtruL/d6GXrTcKjBwiUAxkXP+EW3ujtDwsVNFRjsiswM9gfO
	j3yrA56YSBiBiLVdWkYP+cTLW9ymRdFszso8ZWQsbaFNGxKwf+ly6/dt0/OVn/4vZ8X1023o+2a
	LPMi2Q+znsSkNciDbxRb4lZr0ZJgVWDlJLDtVpBKlsl5gI9ZhankJl5v/wwfu+hxL97QC9bZJsO
	f0R1lIjiW5OQWNvxPI0oB475zjrbaCcc8l3DEQm1On2xn7aZ7otkZerSYQizJNYLo=
X-Received: by 2002:a05:7300:ac90:b0:2b8:5159:eca5 with SMTP id 5a478bee46e88-2bd7bc71d7amr3018015eec.14.1771818877478;
        Sun, 22 Feb 2026 19:54:37 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c6c:6cca:170e:c77b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe82d3sm4446364eec.21.2026.02.22.19.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:54:36 -0800 (PST)
Date: Sun, 22 Feb 2026 19:54:33 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, beomho.seo@samsung.com, jcsing.lee@samsung.com, 
	linux-input@vger.kernel.org, nick.reitemeyer@web.de
Subject: Re: [PATCH] ARM: dts: qcom: msm8960: expressatt: Add
 coreriver,tc360-touchkey
Message-ID: <aZvPUn2RxUHDahfO@google.com>
References: <20251205-expressatt-touchkey-v1-1-1444b927c9f3@gmail.com>
 <532531d2-8f26-4ffa-9355-7821a4d64200@oss.qualcomm.com>
 <1e74b956-a45a-4d3e-b7fa-e4d5dc0390db@gmail.com>
 <97d9d942-236c-4f8a-902e-0ad2ab684a76@oss.qualcomm.com>
 <1ebc2e1b-f1aa-4559-90a0-feb628d5bfe1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ebc2e1b-f1aa-4559-90a0-feb628d5bfe1@gmail.com>

Hi Rudraksha,

On Thu, Feb 19, 2026 at 08:33:43PM -0800, Rudraksha Gupta wrote:
> Hello all,
> 
> 
> Top posting for once (context below).
> 
> Not too sure what the next steps are to get the tm2 touchkey in. Should I
> resend the patch, contact someone else that can help provide guidance, or
> something else?
> 
> 
> Adding Dmitry Torokhov (official maintainer) and Nick Reitemeyer (person who
> introduced this variant).

Sorry, I am not sure what the question is... It seems that you made the
driver work without any additional changes?

> 
> 
> Thanks,
> 
> Rudraksha
> 
> 
> On 12/16/25 04:59, Konrad Dybcio wrote:
> > On 12/9/25 8:10 AM, Rudraksha Gupta wrote:
> > > > > Add the tc360 touchkey. It's unknown if this is the actual model of the
> > > > > touchkey, as downstream doesn't mention a variant, but this works.
> > > > > 
> > > > > Link:
> > > > > https://github.com/LineageOS/android_kernel_samsung_d2/blob/stable/cm-12.0-YNG4N/drivers/input/keyboard/cypress_touchkey_236/Makefile#L5
> > > > This driver mentions a register called CYPRESS_MODULE_VER - maybe
> > > > it could help confirm the model?
> > > > 
> > > > Konrad
> > [...]
> > 
> > > When run on mainline, this is what was outputted:
> > > 
> > > samsung-expressatt:~$ cat /sys/bus/i2c/devices/0-0020/module_version
> > > 0x06
> > > samsung-expressatt:~$ cat /sys/bus/i2c/devices/0-0020/fw_version
> > > 0x09
> > > 
> > > 
> > > fw_version matches downstream ClockworkMod Recovery dmesg:
> > > 
> > > ~ # dmesg | grep "FW Ver"
> > > <3>[    2.201312] cypress_touchkey 16-0020: Touchkey FW Version: 0x09
> > > <3>[    2.206317] cypress_touchkey 16-0020: Touchkey FW Version: 0x09, system_rev: 8
> > > 
> > > 
> > > Unfortunately, I'm not to sure what the other variant versions are, so I will CC the driver's maintainers:
> > > 
> > > MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
> > > MODULE_AUTHOR("Jaechul Lee <jcsing.lee@samsung.com>");
> > Sounds like the best idea, I have no clue either
> > 
> > Konrad
> > 

-- 
Dmitry
