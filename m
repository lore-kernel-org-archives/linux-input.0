Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171A282F15
	for <linux-input@vger.kernel.org>; Wed,  1 Apr 2026 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775019006; cv=none; b=HOldr5bMcYCPaaAREeKwhWWnHIytmpXjrQT1coH6B7iyxVt6+q0H4MbqtiyistqYlUn8OWR3lRE3sXUzX1zoKTUGO+qdq1Q0uUgXHtXxQO+6yLz1J2FTQUmLrzlK7fm7NqvjTwBrS8brtp7zm6uJLVAwWY0qEddQpQV2egsbM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775019006; c=relaxed/simple;
	bh=cz3Xvg0U0I6Gs5gJ8VAhE+Mmd78tyESPPwAOC1A+rPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQcPkCo3KlMR2bA2asuIpCVDLoW2yBzvSRKezO5UfaREHijW9B0hJ7wD7/BW1ywNd9cHN/4poa1pVTNXe73ZzNEjOUegrgvSyKGs31vPWNynX7MK0crlVG1rHbob7CvN5U1/sI2k8VcMnD5NM249Qyuh0RHjoZ681wHNlE6WHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRNHZa8I; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRNHZa8I"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1279eced0b9so8773785c88.0
        for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 21:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775019004; x=1775623804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHQEld5+nd41UvOGakypuczq2ymCpPSNo2keMgfXMas=;
        b=eRNHZa8IMp+7shw6ZAFAgHyGsfwJcU+p1aC6joxKxO42XogFNg+JMZDNITY99Nz+pF
         rZd8ZSkHFguPjFOXEet6KDtAZYbNKspXyNS3KW+6TXm7wnrUKqMwKpywLBjAUMattBzI
         Kp+FnGRsiA7nxPrLacd+4B7qtZAsT20nTx7iwYUglGQODH4nmxAD9eOsPrcJrtOQ1VLB
         R1wZMIC6nU6cdtpr5Q/bLE9vkNsQ540VFCG31C+IK5TpL4AItzNJO9vhMmrYJexJueS4
         wN0R6Z4gFpCaNmU7WLEKdjsIWaH0+Avk7CAL1nqdBayy0ZVymed5GfZk61LNyzm4oGSd
         N2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775019004; x=1775623804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHQEld5+nd41UvOGakypuczq2ymCpPSNo2keMgfXMas=;
        b=U43MENZdPJHZRFdyWb3L1LGF+r2hZ7yWWKXi59G20YYypkPGqKry84SPyrD4mMqEkj
         745vmzlF1tkPGHuIqEb9xMdRk/Go1MHyUzStDMPrwe3ZUjamoPM97hvbYe9g/pIUUod+
         OGymdNlvAteg86gF+kMJuvY5+2XHGPPMBtvkt1ZGJuwSKWC+M+gZb5/AzRter6vhd0Yq
         1d70eUn9rQ1+9jr0/lrKwuP87fbvvXp5ikw214rpEqKeo/S0AScFINupqaf/uTh/VIcY
         rIwhbt2MVRH/do6sa6STEMXdr45vEm6vJqxzDYv2pZm/b0uQgsS8UM23wqXK05N9+XXy
         J8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVz+VLH+mU33/TCIYfQDCiO0ZRLZziD926hMV+DanO5H9gjrmfUIn6zKnAbUzjlfLkatYJwSPBPrjZqpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QhU7MPDMPQnflSqs2BX0m38HODvFFpCIp6YbdUjPAjXmxN+B
	xfB1OvYgZNGVueaoAtzlGtcTW/ieTs8Y9HhIU4BXlWWQYqB+02ltR9UY
X-Gm-Gg: ATEYQzxZJAlXHhl5EkNAWKUYagcJVQXZulwLou/XNXSxPxWI7kcRchGkP87uQSkDPgI
	rmJUfxi4BDPRhunDDS+ixFpr8lQ2X2Lll4hxDyD0yCp6Bh1QT9ow3Kduv6yHimZ4mc66qHtYk5L
	FDIA8OY6Setkd65xyA4e2XAQciantrvAZ/gPDOL8BnfcZmw5d5Jqa5IVzy9/BBZzAjN0LrVC5vp
	O4Pgq971ySiy4PVQFFwel9XMw5fo5P2/rZ2Mk9bsBvoN92IZAyIuxtjadjj4rPLSgCkJLP6g/mC
	UDEKVGWXJVStuZdFo1hP20+RF6XyV6/Ii0INQHLSjYMi9+8H7QR9FYQL4rZg5g6llieoOy/XDpG
	1hyX0Fjb/OcrZWMnvaB7woLYPY8byUR9ik5PGdm1MbCNUkv084Rfk//+N2DOElZBXMPCcD5t7W+
	GF9UsKknWeZy9tiVlDL+3/b5obWR0/io1B2g7UAu9V7WXYDVSvOXcZ97TmFptT5Tbi
X-Received: by 2002:a05:7022:ef18:b0:123:345b:ba05 with SMTP id a92af1059eb24-12be64acde8mr1328345c88.22.1775019004105;
        Tue, 31 Mar 2026 21:50:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:1dbf:b0e0:8ad0:5a2e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm17866414c88.7.2026.03.31.21.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 21:50:03 -0700 (PDT)
Date: Tue, 31 Mar 2026 21:50:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, imx@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] snvs_pwrkey - code improvements and add report event
Message-ID: <acyj0nmx9MRYGjM6@google.com>
References: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>

On Thu, Mar 26, 2026 at 06:39:37PM +0800, Joy Zou wrote:
> This patch series improves the snvs_pwrkey driver with better code quality
> and add report press event.
> 
> The main improvements include:
> 1. Clean up the code by using local device pointers and dev_err_probe() for
> better readability and easier debugging.
> 
> 2. Fix potential event loss during system suspend by reporting key press events
> directly in the interrupt handler.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Please address comments form here:

https://sashiko.dev/#/patchset/20260326-pwrkey-cleanup-v1-0-d85d7c0bf275%40nxp.com

Majority of them seem valid.

Thanks.

-- 
Dmitry
