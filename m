Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C631C43334
	for <linux-input@archiver.kernel.org>; Thu, 21 Jul 2022 11:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiGULBX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 21 Jul 2022 07:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiGULBV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 21 Jul 2022 07:01:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5327BE23
        for <linux-input@vger.kernel.org>; Thu, 21 Jul 2022 04:01:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so4870762pjg.3
        for <linux-input@vger.kernel.org>; Thu, 21 Jul 2022 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hyeeRR7tohL5TMWfdgO05l02fmMCoyNnj27TzJPtGf4=;
        b=T0EP2TPtoyZ/KAk39vzb0Mp6t6x+EWfeWz7SscEMDVfy4F00EPARAuyd0iTQLC0pyw
         OVZNHe/52L7AOPan7XqwC4c5fAxhBdjClT34+r5is632X63OYge45G9XQt+Twl5fqQA7
         QPqcffLoUUmzme+G4inttlIXicIkDaly5yjkOtp+BKP8zXlWSk5qkKgVsLM9SPs0Ipew
         31AwEh6azz+qSMDqZ+Og0n3Edy3zo0vWA5uQ4LMG74xddfMfGYr8DFowi10a5y/lUzcP
         tulEs075P2RpFaq10N062h81Y/W3q5dgpry3iR9S96tAkDWaBhSi/MAC7G0lAOgV+olQ
         4iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hyeeRR7tohL5TMWfdgO05l02fmMCoyNnj27TzJPtGf4=;
        b=ea/V340cFA1dt7iKsPK72o0dLXhNecnXnSg9vJFgcYKk6jTUswWP+hzaUyRY8OyY41
         NoeOAdnTCxfKhIkPvqn6nulscChaVV+zuErlWR1YU5gjDUOBhWjduUAF++GwdK5XzGOa
         z4bs7wTInR8i5W6bKwg6EwV7mC2BOuMhnU+ADxo7mB5KUcE0GNPMXVAnvyVQZdkx2Dgq
         rmLj3wAU+e3i9pxvd0q2RFRbUpuCPjKDDx/k3SU+cJZPAAOLtUeFUp97S+cDQr98of/t
         ua3w2xaDgmUiDujC6uOKR1LC18rd0g36fpFDeSgVTJZI10YbtjayLhvC10iylwxMnlO6
         myIA==
X-Gm-Message-State: AJIora+zQH7vPk5h/Go7DiPl8hqzYTt00YEbgJ1zXF03qHysCab8sHnH
        EApewcqe78nDZ32KG5PrP7g=
X-Google-Smtp-Source: AGRyM1s8kc27nlcwGPL1JPnZKwkyLkp9POBAaw1jp1SwjVsbI3nH2SXB1R4A4N1Ho3Dy5O2SGwPxlQ==
X-Received: by 2002:a17:902:9a0a:b0:16d:1f3f:e181 with SMTP id v10-20020a1709029a0a00b0016d1f3fe181mr8168478plp.158.1658401280442;
        Thu, 21 Jul 2022 04:01:20 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b0016cf8f0bdd5sm1377332pln.108.2022.07.21.04.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 04:01:20 -0700 (PDT)
Date:   Thu, 21 Jul 2022 04:01:16 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     erazor_de@users.sourceforge.net, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: roccat: Fix Use-After-Free in roccat_read
Message-ID: <20220721110116.GA195996@ubuntu>
References: <20220626111330.GA59219@ubuntu>
 <nycvar.YFH.7.76.2207211159210.19850@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2207211159210.19850@cbobk.fhfr.pm>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Jul 21, 2022 at 12:00:05PM +0200, Jiri Kosina wrote:
> Don't we actually need the mutex for much longer period during 
> roccat_report_event()? At minimum it's also manipulating cbuf_end.

I modified the mutex to protect most of the roccat_report_event() 
in the second patch above sent in reply.
Looking again, I submitted the second patch with some confusion. Sorry.

Regards,
Hyunwoo Kim.
