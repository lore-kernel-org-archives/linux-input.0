Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE348B374
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004633; cv=none; b=TnZ7eG3yboA9wRNtYwt9H3w+tYgVfwac+lSYANwH443CYO+tfg3FmHcckZeD6j6IlJeR+z/RgGkRtbu4LGZE+aJIIBX4I4Pa0xZZWsmwfl6ljqiWHmzMOJdsUj7KKMjRpDJM7ErI1DoS2wZ99/4FySxMlrmiF1QEhrOeoK36GGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004633; c=relaxed/simple;
	bh=ElxIShu9MGvxI7R5VGs6SocS6NurX6IGYv2XYH5ULlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTLGSp0jChty2ONC7bjSjcILNyGzadhTxo0rOyposBHV55W+Ihk5hW88JflGGsHKrxpeyikArMDSkRNrFP6CbkVXKbpWT+nQ6Yg8eC5CFMlfca6FQe7eOYN5Wppj0M7qJdnPQxR7WeY7wo5R9qkIUqFLPR9rfqAYz6a1CXGRfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLo+vqj6; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLo+vqj6"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so13323179eec.1
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778004631; x=1778609431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zx1umsJBGhZmdqwnCrzKLY80VDbMmJnRMhO75GMdDI8=;
        b=JLo+vqj6OjmX64DTdv2EKZuKahrXy3mYa8WXVVb0Mh/4LGEg4/IYfAjOj6tYTKbCK3
         L1IHjlXCV05tPq8Dfm52qrtAUvZBK9i8ywXgFAhucceSNoW3valsK2kwYAI2+yMw/jW8
         wL3BgZrYIw+iGwkuse8H1aknJZkegO5d+iBmRHZ3kEgZcVh9IxPcLTN++Xm6D5NzYFDw
         2oa3EelnLn7h66wmDW2MS175k/A/pO8qGrMKn4uPGCjV37eK5LvDKG7rcLry617Q5dIp
         EDX3/5rm66ApK6OOxrkuM3BCWziPtWdFJEazapQDrsBEJ0WD2ZsyqAHv3ZFzN+laP+sN
         yyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778004631; x=1778609431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx1umsJBGhZmdqwnCrzKLY80VDbMmJnRMhO75GMdDI8=;
        b=TCCPgi/T7ut1KCWi4Vd+8W+DvR4zrUcrCLLTmypbtypmjW7F3iCzsteCKSSWPzPKP4
         yBtQGwaH4HQU8kMZIgtbAPWEdJ97+MnTxHcMipNktG0yLRry/tU9jAqqvYg5OOnrujbt
         NM2QwZOcH6Dvkr9+zzQPQgTUL7s93EIXs4wFLvMz4LxAGeLwdNvMNKW86yykSXpQWva3
         BOdckOmKHjw/W2lm8MPA1+jfYokyF9AnmfXOsmKN0k7zY2yw+meYHGIQpf8zyJc0zPRZ
         i3qQs2hBaaUkx7Sn8gqsfJpI+20YR6szlxOCz3AAAN4XFXbQy8a7OGYF3UvMIOxZUJEp
         hwTg==
X-Forwarded-Encrypted: i=1; AFNElJ8ywPjh3+zbV2wpKHLlgJL+PAeoC4eN8ydCIwJYG4cAUtfdNxC85pG2S2KkkGUQBPDgbSU6grTghVINcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPjcuXOn4ZSE1PbfMxhfbnxv2QgA34xZbs4+U2YpoAB47ljMI
	Koo4blbHGnelc5vBiMXwuVoVFg+NTRdT6tWg90b+3tEt+HmzOkMmUHDz
X-Gm-Gg: AeBDievaeCKuoWIJygA6t0t1LNH1THpgzk4gY0bvuQPj5+opnBu9xXf7UJtqJpMrXRv
	Dj+u37FtQx7+I2bnfJxwimKeL0EN5sBog/PTXGHUoItagQZEpc+2AwdzIlufc3bTq7DszJ4q9ot
	z5QA1CvqLhpEhPmM+VoeSPt+w4leJmdC+gXNEFv9ij7lCbLui3RUrKw06Ob61qEoUFTdfF5xqOT
	DvGHguytpDNoMt8med9O0mRIOsDwHdgWb+NCUxL/+OSa+dM7JTQGFxQ9H5NgNdHCKjEAdhylLPb
	Py2yULLNyNMhKh5cjnH2VzdrMzS+D44hrKNiEbAo+mePtDDQZ7BjdlTyx/+N+KVCGLX435Eu467
	FgqtaIs6l69Te/RQPfVaAlExkd7t6eNwHFn3cH864VH0BZzJ4brGTNGWrgUCD6ICEeSCTVIi1SJ
	5S+PSCuL+pPj0fzGVTpXhCvi/UW91IBLAnhwwm8UKQNIoLUenZAohtdN00IA2H4UZHHC3O3pyqB
	Bs=
X-Received: by 2002:a05:7300:ec11:b0:2e5:5bf4:8869 with SMTP id 5a478bee46e88-2f54c87cd18mr185786eec.21.1778004631036;
        Tue, 05 May 2026 11:10:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm28496253eec.1.2026.05.05.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:10:30 -0700 (PDT)
Date: Tue, 5 May 2026 11:10:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <afoyU46tsEhpf0I-@google.com>
References: <20260430173739.3843425-1-kris@embeddedTS.com>
 <aflcL6y_ugHV5p8s@google.com>
 <c49600c3-a78d-4d74-82bd-7f95328388a5@embeddedTS.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49600c3-a78d-4d74-82bd-7f95328388a5@embeddedTS.com>

On Tue, May 05, 2026 at 09:21:50AM -0700, Kris Bahnsen wrote:
> Dmitry,
> 
> On 5/4/26 8:01 PM, Dmitry Torokhov wrote:
> > Hi Kris,
> > 
> > On Thu, Apr 30, 2026 at 05:37:38PM +0000, Kris Bahnsen wrote:
> >> The workaround for XPT2046 clears the command register, giving the
> >> touchscreen controller a NOP. The change incorrectly re-uses the
> >> req->scratch variable which is used as rx_buf for xfer[5], so by
> >> the time xfer[6] occurs, the contents of req->scratch may not be
> >> 0. It was found that the touchscreen controller can end up in
> >> a completely unresponsive state due to it being given a command
> >> the driver does not expect.
> >>
> >> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> >> transmit all 0 bits and use the scratch variable for the rx_buf for
> >> both the 1 byte command to and 2 byte response from the controller.
> >>
> >> This change was tested on real TSC2046 and ADS7843 controllers,
> >> but not the XPT2046 the workaround was originally created for.
> >> Confirming that the original modification to clear the command
> >> register does not impact either real controller.
> >>
> >> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
> >> Cc: stable@vger.kernel.org
> >> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
> >> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> >> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> >> ---
> >>
> >> V1 -> V2: Don't use rx_buf when clearing command reg
> >> V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
> >>           output on xfer with len and NULL buffers
> >>
> >>  drivers/input/touchscreen/ads7846.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> >> index 4b39f7212d35c..488bcc8393293 100644
> >> --- a/drivers/input/touchscreen/ads7846.c
> >> +++ b/drivers/input/touchscreen/ads7846.c
> >> @@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
> >>  	spi_message_add_tail(&req->xfer[5], &req->msg);
> >>  
> >>  	/* clear the command register */
> >> -	req->scratch = 0;
> >> -	req->xfer[6].tx_buf = &req->scratch;
> >> +	req->xfer[6].rx_buf = &req->scratch;
> > 
> > Sashiko (I believe correctly) pointed out that by doing this "scratch"
> > is now write only and this may cause DMA from the device stomp on
> > message status and other unrelated data that shares the same cacheline
> > with scracth. While it was already a problem before now it is even more
> > likely.
> > 
> > Since scratch is now write-only I believe moving it below "sample"
> > forces it into separate cacheline and fixes this problem. Could you
> > please try making this change?
> 
> Apologies, I'm not quite certain I understand what you mean by
> "moving it below sample." Do you mean relocating the xfer[6] block
> immediately below the xfer[3] block like so? If yes, I can get this
> tested and a v4 patch together. If not, can you please clarify?

I meant doing this:

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 093f4b56cc18..04ba98b62f70 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -328,7 +328,6 @@ struct ser_req {
 	u8			ref_on;
 	u8			command;
 	u8			ref_off;
-	u16			scratch;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[8];
 	/*
@@ -336,6 +335,7 @@ struct ser_req {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	__be16 sample ____cacheline_aligned;
+	u16 scratch;
 };
 
 struct ads7845_ser_req {

Thanks.

-- 
Dmitry
