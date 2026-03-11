Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FAF31F98E
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205892; cv=none; b=tX1arLBPdUB20lyyBRQn1qGYj3gsnmy//90H89H68bbpaiz62KOgvAPSrYgTyOtqLfMOHYNiJYANVHXXpgFu24XNjB79Ikm3raxy3NXNoQ4JFw1vuFjHA0H5YLl/f+GxaABNoiKbb+t0EwEjP69rQ2xuFexD9CjP4gsmGQu1I5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205892; c=relaxed/simple;
	bh=SKQebgFHBXfmM2lGdrhEr42Q1f+W474nmfBE0BMUDwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNNMOllOyaXnqwj54vlBAKhwu0ldYmq/1ge6VKPOfX696BEIMG8EAjEpmuoCAOtfSpAJk5Ifgn5JTObUqWAoFMFtAfsNHcoYs4OoEmDcVJkhqfFazK9USVkWfRIgaSCAwCPHyg+1OOc9QKytdVniBLtVD7Q9gveASzq7fF2ND4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6ymUCMH; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6ymUCMH"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128b9b7e3edso574018c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 22:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773205890; x=1773810690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8PBbyOmDB5lQs1yLkLN/9EtPkXrISR2EjJXxH+dMHsM=;
        b=X6ymUCMHD47YPpSQVZeiyGQ4VRiONZq2Gfd2O0oWBh3unN6dyfVvFF/6nJ9aXSwpoG
         Kmke7o9CSbsRL1WhWj5BsOyqhI0/ns8C83AXZy2D60OsQAcQe1h7hWA/qIsra//aQu2Y
         QHg9gsxGxYm100jbBpqRBR+mgBHl0JWjnsHz43qnkEnYnCoQSa/5rkaMiJioIA2DiwKS
         drvFJWQhVhUeaxtaZcdA9zR9ME2Qeg1A3Ujy+ZNGjOx7U5uahsUd2uoMbBWK/AwEVh4f
         3r0rKVBuWX0vgGAfkgQL6479UAt6bkLR+2UPkHBFCCQOLjdW1kpSkkeE+IuZPRgPyHE0
         VxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773205891; x=1773810691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PBbyOmDB5lQs1yLkLN/9EtPkXrISR2EjJXxH+dMHsM=;
        b=tQB4SeWNqIlYIS3BrUMBJ2S1PsFg6XFJMR/FEzOZSLHztJmPc8czOw8OcdU8ibgtQC
         FvE1REPgheTMd8FsrOGqOkPQfInMZhwr4fq3+l9yCAZMRMg4jKeYAKmAHug82m2pnERS
         DlmxmCPFenPYbSAG/XEqrg2E72RiFqN/4EP4OOHknK9iIANKyoXSg3RLu6utsYdFL9fZ
         EnNpDVvHZiXPvYY0PHi2yfcrn1+25w/wZvmNXvfMktgu4yp7WSCGozjJ5ryx1DYKDJU6
         sE5vc+gXAELyGFg879lD9mvmVYLYbXYhU3nwEO2Evo1AMLtWmEAZFhQf4yWtAznaw0s8
         +9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV73yxIbtdNVxciJRhryltbVsFicv9FmRGsdKmlmel/Ucb3s5+Pr170UHB8vkZNi1RJz85XsjsFqUpyLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cqk1gWXCZ1zp8f2LjC/wQGCAikDFwBYm/VhzBvEG/gpo+50v
	3YaqhZpfjTsXsh5oTGSriSehnhBlKZrzk9GHdJMyXOCMHxsFMAGjN9nf
X-Gm-Gg: ATEYQzzjSfE1mJaK/L702BqrdBFNDgu1yP3zFmv/HPDuVpe2mp/1K1bOdOwfAW5v8eW
	QlyuvIWF3urSwgffr7Uhn0Sh27uR4hT94O+oiIEvH+yldF//mkxq087qQMx2MSXp0GctsVKZpSh
	2uxC0KKbJLvFsJuO+3QnPHz42oPZ+9am+wFKxZcpU55WGJ9IFMA6eBrUeH+1Tt3lHn6emdsOtN4
	DkV7OcLs0Xsuu6xiaR6fIHM+ebEvBB8ELTI15IQ6AVldlgSj48oSaPRZFoMNEqxlmSkIn8JD6qw
	nhnbYRW/PTVG2gzHTtZMuU1iW17Rf0BEQ8uCgNtSDduDuK/Gv+QXkQsn1KRwO5qH6e+ZMZtD3Td
	RIjhQhTeJ0cIE2JciJcM5d+EF2so1qqS4pdQjumq9DyQJeKVxZdHfgE1sFR8MQwr21HpKZDN+w+
	A5NnCB2MOQRO0wNI5BSSyX79EBhWXW1+95SiKZXgQ3pzJftRXBf413EqDZ9+DFDpHR
X-Received: by 2002:a05:7022:501:b0:123:331d:bdbb with SMTP id a92af1059eb24-128e781fe8amr639411c88.22.1773205890451;
        Tue, 10 Mar 2026 22:11:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6e17:9d84:ffa0:986b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7c1ff96sm1369730c88.8.2026.03.10.22.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:11:30 -0700 (PDT)
Date: Tue, 10 Mar 2026 22:11:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Subject: Re: [PATCH 02/12] HID: Add BUS_SPI support and define HID_SPI_DEVICE
 macro
Message-ID: <abD5ZAsNOQ-wOkQ9@google.com>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-2-1515ba218f3d@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-send-upstream-v1-2-1515ba218f3d@chromium.org>

On Tue, Mar 03, 2026 at 06:12:54AM +0000, Jingyuan Liang wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
> 
> If connecting a hid_device with bus field indicating BUS_SPI print out
> "SPI" in the debug print.
> 
> Macro sets the bus field to BUS_SPI and uses arguments to set vendor
> product fields.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
>  drivers/hid/hid-core.c | 3 +++
>  include/linux/hid.h    | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a5b3a8ca2fcb..813c9c743ccd 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2316,6 +2316,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
>  	case BUS_I2C:
>  		bus = "I2C";
>  		break;
> +	case BUS_SPI:
> +		bus = "SPI";
> +		break;
>  	case BUS_SDW:
>  		bus = "SOUNDWIRE";
>  		break;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index dce862cafbbd..957f322a0ebd 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -786,6 +786,8 @@ struct hid_descriptor {
>  	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
>  #define HID_I2C_DEVICE(ven, prod)				\
>  	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
> +#define HID_SPI_DEVICE(ven, prod)				\
> +	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
>  
>  #define HID_REPORT_ID(rep) \
>  	.report_type = (rep)

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
