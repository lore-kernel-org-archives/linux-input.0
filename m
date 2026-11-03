Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736275;
	b=3M71v8JmCZGShN6CUynRBWW2KbbD93QusSHL58+GJ8u7ANkKhWKTFU/naO0DSIBHUHuQ
	 s/dViWu4LoxC5OqHKwv4qOAGDvRke0Tfn5HU2mblJMFu58dkR5aByYyePc6vNYpRsVzD6
	 DedFW2YEMDYHmpnXLsIljh1De6X5JTbpN64UmMdb6/mJvJHctjSR3ej6PXbgcMksBRz5+
	 CWMuppD9wV1E0+KhIVPUOXGsAEnae0/7pjfBEb7h7znfciZJqth2qEMR9intkauiefUD1
	 a0E4Hwgx097+wvCgh4qCnLVHmaUG9sgZd5tN4P3cTbZG1cj2jCpYDfH0PojAT/zzZAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
	b=tN5xGo++2dkGzveeGSCjRyTkuioEcnbT7E3lTBSC5LAT35Ses1LSZpZB7ryeLTbBEKKE
	 /6I8rXyTZk2IX9hwP1yEd9zVgY9JZbpeujzcTo/IVLdIe+iBu6y3raYmbHMTVmYpxT3rh
	 5+R3duG0I/KeWOAxPO8qr0eqCFq7pej3uPi4H+2y2148wmZHkZIoqSpvAddvnA40JIICV
	 khojPQB6lwybKPwgrR6HGh9hLrDMIefWw5Ze53By3kBeZe/ySJVFVxHH/yen651JC1tEP
	 CSLfIFx+bBU8G0jnsNGak4nxukCunq1PgF3NnYpD/+5leoPJeSE8/gco7k+TsEMv9pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MY3vc6Gb;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28239606A32E
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 20:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28239606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MY3vc6Gb
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a18fc7a38so8824262eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793736274; x=1794341074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
        b=MY3vc6Gbvvfq42ubgxn7ZiALrft/xLB+7RdNtGFpyhdTAWULvE/ASxqtUVijeZaLAG
         pFKwTl7Old40mDX8hTr504VOvLwRmf6WVo0XKxWHImHyLsyuvO5cI1YC7tyUOb9E2Ov4
         ZupY/VOPLYTmU/TSmjc5sIO5R0nqbRrhc3gWtc1PAW4PGvUZRAa5TTXXr/Ol/wguGV04
         /NyrkwL8H+JcKuFKPUwQu2sHRwhVoxKd3+a7lgDpWBVwlzlTOj+u8qnjv3odQL7LHfl6
         id4GY7sKuMug1ts1LrY+1VLRHv5zI9HugBWlvGhAGFXapCIpnKpd9Sz4vKeVcJt7nGUP
         lk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736274; x=1794341074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
        b=qpxhxJtOsBMKNXLkPqw6flG2MoMqnI1I8vfV6Sv+XOBbSGygPHjgv1XiBY7W3r0aBO
         XhCr76Ywizy6gYBkb55K+ZEG5EvBcKbmdEP4rFd87vUpmshfYQpHQDs9k5I1FcS/wHyu
         cH4Z1Pqm8/jlSHcMkJmiRM91esQJmEjEtecpQXHmp7R0NgtBtGKiCX4rinJxZq3sOC7V
         OkGVmQaU1RikmwVUmAvTEZAEElW+AuWDbPT9eDuiXTrXyxLPLtXNQw/P6bm6Bcdh5CE9
         9gTNwXfSlYoahDnoMjmgXbZ57W8aICxo1wTOVmsb9PP9LBj2RJ8PYyG6bc2ETDpkDA39
         og4A==
X-Forwarded-Encrypted: i=1; AKwUvBxSLWkYgUtgcb2P7PR3/vk/hy7LyUvZ8+aSp06kJPO6NIGZBjISYV6mN/h+Et9f1x1SAsbm4bVSfJ2sfA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9hyrrNndOdEudHb+6oNA+Hu1MrxVrX0Ex6jN4Dc0xpE2GpbiPr
	ebRwHpDgvIscAgOTltZMEn7NoioF9xdyq2Hviwf26qx6zZP36j9ltyM+
X-Gm-Gg: AYBFou1nUn7zKxhLAseYSLncwVa8Ja8x27uZ9AKtUWJmGXmtbubv8LyS58LzfkPB1Br
	4JPHtDqndP5G1ybv8bCN8VQvH9efTiGJ0rBPqcc7//BRj+9lKI5pwrvi4nVvoWJjmBO+ViFpb3+
	T5p/qYk4Tcqr6Qcr1zLwVhv/QB52AiSpS/gUgfWeiqs7rez9I5+neRofoPG/QEbhC5lc/WCA5Z1
	CM6arJ0VqdVCFJeeQKwIebgVIFTun2ZZd2KzfiarwudfxnrkXs/ekkg8Khkl1wsaU4wZFMOazhu
	4EwAv/uNCgzTk9Si/VPW2K8TnDOSoUpTmEfynghCwYDDaChKtHwT5i1Qyts0AGln7jG/aDvc9fo
	PfZrc98n2crLVQs3b39IaAwIncf7U49UH5ZjIXoGIGXf0QuOCvjIewnRq5yoivJgrrrmiymiw7C
	s5JhSQfc73TFrQtBNW61GxCWoCqifQnYYGTty0i4Yr5v+2TYjoRd2Bh5YB1Nzy7BEv8CQtAOPN7
	vn9N2QW4wL6DPcoToqB8Ybc1APDHCbNEQ7QmrZ8vu9EKciP0Tl5B0UmarsG5i4SXMjO2HYDj9US
	ixTqqvtRzYbUruP0OLbz3EageDxG9LDEGNNdpjzj7j5tUNaI+XhkpTbJolJST+NJcZje
X-Received: by 2002:a05:7300:824b:b0:36a:1c75:8ca3 with SMTP id 5a478bee46e88-36a4221b3b9mr19658147eec.1.1793736274072;
        Tue, 03 Nov 2026 12:04:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm368905eec.9.2026.11.03.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:04:33 -0800 (PST)
Date: Tue, 3 Nov 2026 12:04:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>, 
	Corey Minyard <corey@minyard.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data()
 prototype in writing-clients
Message-ID: <auo-JCn9VES7OwX5@google.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>
 <auI4Qq1KUo7YYVtG@zenone.zhora.eu>
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
In-Reply-To: <auI4Qq1KUo7YYVtG@zenone.zhora.eu>

On Wed, Oct 28, 2026 at 07:00:49PM +0100, Andi Shyti wrote:
> Hi Dmitry,
> 
> On Sat, Oct 24, 2026 at 07:48:42PM -0700, Dmitry Torokhov wrote:
> > Update the prototype of i2c_smbus_read_block_data() in the SMBus
> > protocol function table to include the length parameter.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi, so will you be picking up the patches affecting drivers/i2c?

Thanks.

-- 
Dmitry
