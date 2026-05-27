Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351A35B653
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779918077; cv=none; b=prrsfr5bZlgW15ZzEgjAPysZTlEjgEnneE2O2c1f8EEpvllVitTU9m03EpfHXg8w2NkE6iWfT0KfTiOrJs8HtwD6LGPDxmGsQ9yTwwnKtNcA6zDtJ3NrUSDyKMW7XrLrl9amliwwBZfBzUxulJZ0JBUBTMzwwW8MsqXQFPnAiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779918077; c=relaxed/simple;
	bh=H2q+9lVRHkFpT8xh7oZtUq8sMwBtqlHtfDEZCw5om4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyBcuCm/ISWIJAEW906g4J66v8dNFktXUh7K1In1fqFyc2+5xENX0U/g0ovehL0eSPGUIqDq01T1dHZkWTQUrq2ITR89C4Tjo+dJDPNS9ocB47UG/JPTGpDhulCmOCeKjZDjLhRaQ2qsZ6Vetj6l97Ec34ZGbU1wn+JTcpiWVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldgqd+AU; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldgqd+AU"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1363fe80fe8so6870522c88.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779918075; x=1780522875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyVWwIzkff7WseZ7Vmlrgtp+ZrMXZZPNibWetKjmvpU=;
        b=ldgqd+AUgVcfxbvbOLtUqXcvx3judn7jP4+Nv2pbYdeLb3DaNWjq/GcVcnzRhI0Rwk
         Z7se6IUlDh0MrXTbmlZBh+RcZg6IfhoaaxjvmEXOXFHdU5fAPspTY79wHP/CDGrqiEHI
         UEkP+8Amc301c989eKdpZFr9MOIesjV/t/T6IXrj/w4YnUzpEmF83i0kJLheSJnLaj+x
         6TaWmN5RYi8vo9PWcXNB+rovSR0C3Gsh5iyi5EZwP1hpS2qxTvHjgO8odb726WgUQfcD
         29ZIQphl9MhoxP7b3SlITrSiYSAzyd/iijhtRK0Q8cZJso338VfgBz2Odn1YBPZJpFue
         8Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779918075; x=1780522875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyVWwIzkff7WseZ7Vmlrgtp+ZrMXZZPNibWetKjmvpU=;
        b=rFGIPcYfE6il8stEucWxpNWPAN8IcoFhUXoSy/Gmt7qYcJmaGITg+fKOCJiDxFSLx7
         BIjzGr62B/LYYJ1dGXRoKsrfZ3SSQlEjm/EP8/wpiics4UY5it0xhOrv1oiyMq6fwqab
         D0DI4AIpkyjMoXs+8YYH3H8a/AYlgmrUIeo3GFKpDpLogBH2G0fru8Ic6jiW/bRIHhB3
         mokw+//cLnoxIMHJ8f8f/0HXjAd8fzFhh9A1IKVKn9hHbkjprb4jfmud6UUf7iaeiS9K
         Fput33Y62y5fX+IR5fGrRPBcRZiVdk4Op19CruCgXd9WPZOr34Kk1hP24KS4+jAMegLd
         e8Ww==
X-Forwarded-Encrypted: i=1; AFNElJ9p28tzbtf08iZnCLNBFbcDiOZYCPFQWLThMbDRhe/KzIoFmAg+Cs30X13SsFZbiRT0T7AXcMvBufh0ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7zcpHJrqhxchzZipy2x2iLWLevCa/Gcc0XZV/JXaHy2eafC4
	3MCaVVZ5RHcxvGh+SsxjZFaYsFDvMGmpj/ymHwhXNtdy5iGCDDIP5OGI
X-Gm-Gg: Acq92OGLo8UBlao4cryQMux3F1oYTzuEWjJQqzD4MboWMWdjxrDpVF7lFLfFjB91o9G
	xSqPTUUJzlRtA6/Rut0PtL6nN3QgH88jV/uhq4DesDoFW20Ls8MFCA4+2nLm05rYlKgx41qotzZ
	oXiX8KzSpZx48Pu/ayPPEyeihebduMt2voClAOg5G3yEeE0xXnt+Ls1wC8WIuO/UuU4sr/k/I/T
	s30tkC86eXA6ZT6I6HuYK0v5SOa25sd876lnkQ8zvWrTbIrkEUeAEqdRQ3sTzEUtxdP6H1ks+Ex
	yuWvEtjERYwV0kYxLlgROA3WsNdHfVdEel96hyv1UVqb7dDDM1U3O+fGPx73RDyiFN9FWrTJZP0
	rUYRwJGoBKnAre0n7TP+PbL144LE+T2WWc0FgeBT0SbdhqqypeGR87dhEpj/EX/ajmGuysVrn86
	sg4gLZIB2XyDDj69tak27JMAamKchMs1P7k6u092L9NEfP0tfduUhuvcn3M3UC2jo9d/ORerwwa
	IM=
X-Received: by 2002:a05:7022:618e:b0:137:5b9d:cf87 with SMTP id a92af1059eb24-1375b9dd5e3mr1725302c88.0.1779918074854;
        Wed, 27 May 2026 14:41:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ca8d:7a6a:7fd3:5948])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm11128204c88.10.2026.05.27.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 14:41:14 -0700 (PDT)
Date: Wed, 27 May 2026 14:41:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: Jason Gerecke <jason.gerecke@wacom.com>, 
	Ping Cheng <ping.cheng@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: validate report size before kfifo insert
Message-ID: <ahdgcqtACd-PGmzJ@google.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
 <20260524135203.1996265-2-jinmo44.yang@gmail.com>
 <ahdJzWhVFm7mWu-v@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahdJzWhVFm7mWu-v@google.com>

On Wed, May 27, 2026 at 12:47:03PM -0700, Dmitry Torokhov wrote:
> On Sun, May 24, 2026 at 10:52:03PM +0900, Jinmo Yang wrote:
> > wacom_wac_queue_insert() passes the report size directly to kfifo_in()
> > without checking whether the report fits in the kfifo buffer.
> > 
> > Since commit 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX
> > limit"), the kfifo is sized dynamically as min(PAGE_SIZE, 10 * pktlen),
> > which can be as small as 256 bytes. However, reports received via
> > UHID_INPUT2 can be up to UHID_DATA_MAX (4096) bytes. When such an
> > oversized report reaches wacom_wac_queue_insert(), the existing
> > kfifo_avail() loop cannot make room for a record larger than the total
> > buffer, causing kfifo_copy_in() to memcpy up to 3840 bytes past the
> > slab allocation.
> 
> Does it? Or maybe spins there indefinitely? Also, doesn't
> kfifo_copy_in() return 0 if a record it too big and not copy anything?

OK, so the root cause is that kfifo_skip() must not be called on an
empty fifo. I think you want the code to look something like this:

static void wacom_wac_queue_insert(struct hid_device *hdev,
				   struct kfifo_rec_ptr_2 *fifo,
				   u8 *raw_data, int size)
{
	bool warned = false;

	while (kfifo_avail(fifo) < size && !kfifo_is_empty(fifo)) {
		if (!warned)
			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);
		warned = true;

		kfifo_skip(fifo);
	}

	if (!kfifo_in(fifo, raw_data, size))
		hid_warn_ratelimited(hdev, "%s: report is too large (%d)\n",
				     __func__, size);
}

Thanks.

-- 
Dmitry
