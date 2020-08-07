Return-Path: <SRS0=egkw=BR=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591A5C433DF
	for <linux-input@archiver.kernel.org>; Fri,  7 Aug 2020 00:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C732221E4
	for <linux-input@archiver.kernel.org>; Fri,  7 Aug 2020 00:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVLJ1U68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHGAhN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHGAhM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2020 20:37:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE4AC061574;
        Thu,  6 Aug 2020 17:37:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so224733ply.11;
        Thu, 06 Aug 2020 17:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iLmRev1FWDw5vshgDSQ8C//GCByvskmycWaOHYHUkOg=;
        b=fVLJ1U68CL4TwVKbQf2xudL8L7IHf9IXXDCKGxeDchkPVt5SbkKW++ShVpEqZ/cQOa
         GofW+CxvAMupctJ+JzdGJE+OUXKdZOd0JTCj8a3My2HH6NQBTO6dkBy7j8Jz7oinv3U5
         aMkMXIhPLbfMPamV/dwtRm/INhHvPz/6QWs5jc+QdiehvoohFH8OS5sFJ6WLWEe3jGlt
         PiPL/wiQWkA4GkcKYrl0+pDi6HLAh/P7htaibTwprhx9bPwid8D6Ou5gi3dh0FL4UZgv
         5cIqcggRw3vcmwJK9VXqy34Kp08mwGdVr5ATmwW8yfk5cVToAs6pQ2uDcXEWZm9YpPH8
         ZxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iLmRev1FWDw5vshgDSQ8C//GCByvskmycWaOHYHUkOg=;
        b=ZikByCXj1E/P1bYKz1KO6ZrGMfxk5JQGzNAaLXWBBV9sSt2K0tnv1hq4zltDpWE7V8
         WxnpzO73RIsTMOOWklp1NdqIwQn6TQaifX26bPNS1DixboDqKyeiHDCnIUXsUahSqD1I
         afDbic/aEnGKFMeEMJ1nf1uyT3lUx3uq6LfEK42PUfA04tGYHMJUvemypCelbOfmu8Im
         PcoK51lv/dWyGdFVy7xrUXDUZyQX3CtzxTHJjXSBNc0d3/qHVFNasV8SvxXoOUXY+e6l
         FL9wtharjPZiDqrTB8GTmCZGMGbKOOUJHtllBFCVgXYxYRJtCXg5r82qAO3L7F8ce2sD
         ym9w==
X-Gm-Message-State: AOAM530MnlkBuepnqTZ3AgYJX4TX5i8u7ALSHHzyAA0EDT0K6gGDDW2Q
        KXGtC+S5C1u3rNu7Kbwl2Cc=
X-Google-Smtp-Source: ABdhPJwswFLYESipwn5RAkx5tM3mwoch4VWujx+zqjmJuEHJrobVl7rc1d7kqsVSCKe2qHbz4crYrg==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr10763523pln.16.1596760632144;
        Thu, 06 Aug 2020 17:37:12 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x23sm9411544pfi.60.2020.08.06.17.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 17:37:11 -0700 (PDT)
Date:   Thu, 6 Aug 2020 17:37:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Ahmet Inan <inan@distec.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv4 2/4] Input: EXC3000: add EXC80H60 and EXC80H84 support
Message-ID: <20200807003709.GO1665100@dtor-ws>
References: <20200805160520.456570-1-sebastian.reichel@collabora.com>
 <20200805160520.456570-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805160520.456570-3-sebastian.reichel@collabora.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Aug 05, 2020 at 06:05:18PM +0200, Sebastian Reichel wrote:
> This adds support for EXC80H60 and EXCH84 controllers, which
> use a different event type id and have two extra bits for the
> resolution (so the maximum is 16K instead of 4K).
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied, thank you.

-- 
Dmitry
