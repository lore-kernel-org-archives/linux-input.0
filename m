Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736AA517BC3
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575467; cv=none; b=BJvWZxRYzmILz8E/uFMxRxrHXPZRGkNqEP2qvPl4Tq30ae8cxXWhNHRF9Tw/nsLNDOBNgNex3xmLNprGSWEb+v07MxzD6/9pNXwos52C3LrKRJClvKnZ5RiBcCj1gbx7J1CJ6ceDwJaMQSELdfhMliAED6ZbW5xcX3dZkd11cfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575467; c=relaxed/simple;
	bh=dNHP1gTsQIZoj7AUrk+3cvNZFuIo9EZylbWDUYMpxEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxWX3WjhtyhSHgyCgpJQxCpioCAdADDvHLQbTlXPEcDUF5q9JqtsmKeMnCZrgNxbxUVfdz+nEjFDdjW3X7C/ULRLrV3qm/eYSBs0Mq263/KmTcuyrn6G3pJquz3buakE2fLENhNFaAiphEk+//uWm3535LnzKr1pY8O15Jjr3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPLwmdiR; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPLwmdiR"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so1036479a12.2
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789575464; x=1790180264; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fHyHl8JYGeK0KYa1UKcPeUzjQ3WV6y/WuzNvw68/Tik=;
        b=oPLwmdiRoFINGnyPsdhOTtRjjGUgIlLZfCjuBZfIUKM8b5RtoRteggfcrSyhGE3OrA
         +moWQ4m/jAIn+poelfpLshgvDl3qQ4v3J1ZRMMp86DfS//sguxfT9twfioNW+u7rDiOk
         OGcc22X5TxIkLT8FjQDD79hu7TCQb8WAKoVG549CZICNoTcp2lqrzqa6zHvsXhnMfaWc
         XZyYcSa9QH5y/99rNMM/q4ouYtEP+gXsOZi/2uOV4cqYBnDPGPoR1vsAmuYGn2yWiaTF
         qtH0WGz48LD/Ikzm+LFE8pQA0Y7FjJZxfRX6gPNCiIFpfI08hL4d/Z2OnXNqqHCDMVLG
         MBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575464; x=1790180264;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fHyHl8JYGeK0KYa1UKcPeUzjQ3WV6y/WuzNvw68/Tik=;
        b=wLGq9IQvuj+cRCa9kcDvm+ybQhLoR8I3Zh6es97Z7T7G9y6v3XmbD7LjWwaNSvFg1+
         gbNukyh1ITtdfPt4GSd6kcmSTIbGp3NlQcvUaIwqSL4yCE8YIJ+7q8CKVWFMFom2poed
         qVR5oT9SliwiJh4pczSAcbdJS/9X9HT6bA5WRG3oFCIcaeg0UMoA9F18VpJRUwG9RPaW
         8XTsxi4rG7N4H42Bfo01BGZVMTTXBy5j6qwreVTImcQT6bYjzfbDHL4fgCs8N52wu/yX
         ufA7t+stkBzgh6azi5O/SsbBVfE901Rc7co0k4eSoHicqCx+l+H3G8Tr/F3UVpU29PmQ
         V7jA==
X-Gm-Message-State: AFuF++mGDtDqU5q7ujS0iP0a0MTFursPtaG9HrpV69jOklAQQJ5wrnsT
	ums4FMFBonnUNj4mzHR57/B8MW0NMq24b+mFjZF7yJZ0lckX3us/rM7R
X-Gm-Gg: AYBFou33At0dG7VV130K5wPi1PQ1vpbW3RuRYJ7ytdoUsAsfEPToB84ewurNwc/bCuL
	iRp+tfzFq2BwqDUv8Uz1TcLI4wK/AbtypNOuhdXkj6Wg6yyHXvPsMUx6bPYR48pwNXzXSgn8iBL
	TncPka9XVP7BsTqN/Io/SMEdpddaW+9FEwNY1B9lqEtvQv1Lz1+92Mh5o35BEnb5mCGA6271nJs
	d6FPBKMzLOa4m6HtrUXyAW9VPGzUxDgoifJ05oSI1xgiP8HETRk9+JJTem8p05jkLygUAR/0GcY
	ueU5dMQKo1xXzXilBI+2qPTrF81d+QbLtdzn/PfyyHfaltjYvwADkm7ez1NgdIDdVEqgEttQ9uz
	uC6bJOg9sTEPAtELzMxLAh4fymo+jGWvRSKUIZvnATPTLiLzDYsb6ynEl1KdFncTKMXoOavJtzg
	X9/O4plNKEtJdNqa62JBtfUaVR6FAXOwP7EwDAYQ1xs0zv65eqo4j/scyln1bnLk8aXOfDFasPc
	7HHpBdEOZChCebofwcckx/bIyegHTkksyB+rPR8qk0gAuPg
X-Received: by 2002:a17:90b:1a88:b0:396:6344:3b63 with SMTP id 98e67ed59e1d1-39e1e27dfe7mr7308938a91.2.1789575464203;
        Wed, 16 Sep 2026 09:17:44 -0700 (PDT)
Received: from eggarch ([2409:40c4:18:7581:88e6:16cb:6cd3:1ba1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35d9b298sm251787a91.2.2026.09.16.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:17:43 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:47:37 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Pujito Adnyana <zhee.tou@gmail.com>
Cc: linux-input@vger.kernel.org, 
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Internal keyboard dead on ADVAN 1405 (APN21S-140P3-CS): i8042
 controller OK, keyboard device never ACKs
Message-ID: <aqrA0eEt89mr_ijV@eggarch>
References: <CAEkMyrhPTh1Ws0Co6zHBq1aMhrhgam4yPBgbXAMPrffyAKpT4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEkMyrhPTh1Ws0Co6zHBq1aMhrhgam4yPBgbXAMPrffyAKpT4Q@mail.gmail.com>

Hi thanks for the report,

On Mon, Sep 14, 2026 at 08:14:24AM +0800, Pujito Adnyana wrote:
> i8042: [943273] f6 -> i8042 (kbd-data)
> i8042: [943474] fa <- i8042 (flush, kbd)
> i8042: [943474] Interrupt 1, without any data
> 
> The fa arrived roughly 200 ms after the command was sent — just past
> the timeout, so the driver had already given up and the byte was
> discarded during the flush. The accompanying "Interrupt 1, without any
Yeah that seems like the cause.

> Is there a way to make atkbd tolerate an acknowledgement that arrives
> just past the command timeout, or to retry enabling scanning after the
> initial probe? If a DMI quirk is the right mechanism here, I am happy
> to test patches and provide any further data needed.
We could keep the current 200 ms attempt and if it fails retry a few times.

Could you apply the patch below against a mainline tree and test it?

Thanks,
Lovekesh

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index b9ad2381f885..81df4b7a5685 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -714,12 +714,28 @@ static inline void atkbd_disable(struct atkbd *atkbd)
 static int atkbd_activate(struct atkbd *atkbd)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
+	int error;
 
 /*
  * Enable the keyboard to receive keystrokes.
  */
+
+	error = ps2_command(ps2dev, NULL, ATKBD_CMD_ENABLE);
+	if (!error)
+		return 0;
+
+	ps2_begin_command(ps2dev);
+
+	for(int i = 0; i < 3; i++) {
+		error = ps2_sendbyte(ps2dev, ATKBD_CMD_ENABLE & 0xff, 1000);
+		if (!error) {
+			break;
+		}
+	}
+	ps2_end_command(ps2dev);
+
 
-	if (ps2_command(ps2dev, NULL, ATKBD_CMD_ENABLE)) {
+	if (error) {
 		dev_err(&ps2dev->serio->dev,
 			"Failed to enable keyboard on %s\n",
 			ps2dev->serio->phys);
-- 
2.55.0
