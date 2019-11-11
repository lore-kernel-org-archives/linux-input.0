Return-Path: <SRS0=oPMK=ZD=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C694C17445
	for <linux-input@archiver.kernel.org>; Mon, 11 Nov 2019 19:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F4D2184C
	for <linux-input@archiver.kernel.org>; Mon, 11 Nov 2019 19:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWNMb+EE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKKTXo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:23:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42360 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfKKTXo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Nov 2019 14:23:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id j12so8166891plt.9;
        Mon, 11 Nov 2019 11:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqBoU8uO1HBJIobqBNdePdaIztSNDwAAWaWkC4C27oE=;
        b=TWNMb+EE3dvIlfUfYNhhjAOhHOER24yqR/rGWwoow4d3xdJD49CFmMqOFnh4STeooR
         ODczjcJktD9PCe/gNFxeMgPvKldLxCt+kTp5P+3fixURo4vj77uhybLCI3WrwtNkLVCS
         cJ9H/8Nj80Hhj3J1xmTNgU78WRrfspF+MQfSRrh01dTM3hegHN3S+P1n4xZU0wHimpzs
         r+YFNa46x4H76x2EosjNSiPA7gsK4t4NbxB+NYLOQ8Aq8HtiMCjw3MqeDAsFx2uKDYHq
         yiGHidR/aAkWdhOkiIIjBJWhEOFZ0JPiWWU2oIBYL10/91BPw9KWeAreNARNyGODHvzv
         Eb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqBoU8uO1HBJIobqBNdePdaIztSNDwAAWaWkC4C27oE=;
        b=WHSg2zPF9TMz6XCFpkFWOBWg+xSeUhWNLET3hbkMxgIKmVYf84ynj0MWGHWVypwM19
         AxXUK42yU4m0wMC8AVgiQG+mTcYlKo7xGHhXyk1bIpxGm9s4NwrDxk7TMlxqdGyqwoxh
         x+M/s6XmgA/Tn9DIxF5xXHYinl8bLsnptiVO0jZRP27ug3l+Fd7fIpE4Lngb68LeRoC+
         BOhZ2qVOakB9frfDQGUwRhNI/R90pDaFNS+e2S4xXTJqBa6FN80if1lotsz/IiOgiu3A
         xUYe43ilwGtjF0yzJdtHQKgEhcOhyMRflUQ8610rGhbvcID5J0Kf4z3DYT2BzaIALPqU
         NHvQ==
X-Gm-Message-State: APjAAAVT1yfuCF1lfL0YjfAf4AxbK1psLP8MS0T2ifPPg7QUtkOAHM0k
        QZ8enDmGlU3aNhRpGqGDAVI=
X-Google-Smtp-Source: APXvYqyIHsdlmJbhKdJzxA7u2YLwOc+ayB0K2KT6S/EU0y4GfOFpj48/Zd53w2PBFPhvl4R9xOHF8g==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr227370plk.173.1573500222872;
        Mon, 11 Nov 2019 11:23:42 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a12sm15416253pfk.188.2019.11.11.11.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 11:23:42 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:23:39 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, briannorris@chromium.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dtor@google.com>
Subject: Re: [PATCH v4 07/17] Revert "Input: cros_ec_keyb - add back missing
 mask for event_type"
Message-ID: <20191111192339.GD57214@dtor-ws>
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-8-gwendal@chromium.org>
 <30edd741-310a-9c94-78ed-74dec084f382@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30edd741-310a-9c94-78ed-74dec084f382@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Nov 11, 2019 at 10:20:05AM +0100, Enric Balletbo i Serra wrote:
> Hi,
> 
> cc'in Dmitry and linux-input list which is missing

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Enric, please use my @gmail address for upstream stuff. Thanks!

-- 
Dmitry
