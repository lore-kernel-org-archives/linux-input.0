Return-Path: <SRS0=THGL=7J=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4511C433E0
	for <linux-input@archiver.kernel.org>; Wed, 27 May 2020 06:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A9A20663
	for <linux-input@archiver.kernel.org>; Wed, 27 May 2020 06:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQNBjaup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgE0GKX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 27 May 2020 02:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0GKX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 27 May 2020 02:10:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3CBC061A0F
        for <linux-input@vger.kernel.org>; Tue, 26 May 2020 23:10:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fs4so1087220pjb.5
        for <linux-input@vger.kernel.org>; Tue, 26 May 2020 23:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YbSTO4In4Z0fkD068MkmKlsSmRySaTVdA7HLTQm/thY=;
        b=FQNBjaupx2KdhexOEJ+CjbD28V/GfPm20j9RMlYezz0rs0/qob4bR96vTJj74xFIH1
         eAt43MTRuDcaDRE9fykv4FDjHCv+lP4f7oSMWUECiAyGjaJJbjs/By/LKZQmx5mblgli
         vyrdwJU470vz0N3Ui5Tih48rlgFMaIUbB6XSN2p3VluesIPlKsW+swOUmzSHc7azo2/5
         0xxkiDGq3hJTarOkd21r70G1Pd+kOH/asskxnaXnrjAWrDTo71tGL9y2JoneAdulFEbh
         PZLHGLKWuflfQWkDogZe7kcSiNO88/vGGpCIhHO9I6j89iEqVrItUBJPRckg+wG360AX
         vh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YbSTO4In4Z0fkD068MkmKlsSmRySaTVdA7HLTQm/thY=;
        b=hK3N769cd2kReiUn18f2vsyK9S2DiF2HjGAGoUpleM9WGGU5NOl+hsNMblkVRajNRz
         v0+cCkDu3XPHmsIncbNDneNfh3uk2yVS2pGCCPp7F0SIgU8fExFjqGN4mHlBw+iRylQZ
         BHHjZD1Kf6LDd/Ys9aef4wK6d9uK7GfvEN5/BGnZULReUylZge52uH+rMHLji1r0J8LN
         3LCQ9XnxaMfChO3OUqk7YvCVa6qEdkKzRUK6lL1s0QBaDnOVEectkGnFHt3eKLjxZWQu
         mBxDhZqbC+V+fO25Dw8zNhhcFuSiR9Vul81evm40w1CHigRurLG8e80uTRMNBJ9netcb
         X1ag==
X-Gm-Message-State: AOAM532sUfhfe4yyjoVd+w36hU+2696bdzAtj00KoAn44XzmI0CAwUjf
        zwhggw6M/l660CTAGYnIkZ0bWnsU
X-Google-Smtp-Source: ABdhPJwbd2atEVtliYk5d7DHZiZbXZ/eS4FbU/wm2AoEzwZNnmJhlLdmkDSOsNJ1+vWk2UWUUBuYHQ==
X-Received: by 2002:a17:902:6902:: with SMTP id j2mr4574200plk.2.1590559822128;
        Tue, 26 May 2020 23:10:22 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id g1sm1098680pfo.142.2020.05.26.23.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 23:10:21 -0700 (PDT)
Date:   Tue, 26 May 2020 23:10:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     <denk@eclipso.email>
Cc:     linux-input@vger.kernel.org
Subject: Re: Re: Re: Add a second working PNP_ID for a T470s
Message-ID: <20200527061019.GI89269@dtor-ws>
References: <ff770543cd53ae818363c0fe86477965@mail.eclipso.de>
 <20200424222546.GK125362@dtor-ws>
 <1a56dbaf4c20a4a375da9a6d281b865b@mail.eclipso.de>
 <a6c89d6692bd551617dfaaf9275e7cea@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c89d6692bd551617dfaaf9275e7cea@mail.eclipso.de>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Dennis,

On Fri, May 22, 2020 at 01:42:35PM +0200,   wrote:
> Hi Dmitry,
> 
> as far as I can see, there was no reply from you. If so, then I may have missed that, sorry for that.
> As I said I am not aware of any issues when running the touchpad and trackpoint with RMI4. The only difference is the mentioned error message during shutdown, which I would like to get rid of, if possible.
> Can the patch be merged? Anything missing for that?

Sorry, my fault as I have been busy lately and my patch queue grew
really long. The patch is applied, thank you for your work (and
patience).

Thanks.

-- 
Dmitry
