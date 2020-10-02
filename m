Return-Path: <SRS0=ejGl=DJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46356C4363D
	for <linux-input@archiver.kernel.org>; Fri,  2 Oct 2020 12:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FAE20795
	for <linux-input@archiver.kernel.org>; Fri,  2 Oct 2020 12:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbgJBMdW (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:33:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49272 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbgJBMdW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2020 08:33:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 538D429CF39
Subject: Re: [PATCH v3 0/2] Add configurable handler to execute a compound
 action
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@collabora.com
References: <20200818112825.6445-1-andrzej.p@collabora.com>
 <20201002123158.GA3346786@kroah.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <95030036-87fe-8c61-6fc6-c60452d8ca96@collabora.com>
Date:   Fri, 2 Oct 2020 14:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002123158.GA3346786@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

W dniu 02.10.2020 o 14:31, Greg Kroah-Hartman pisze:
> On Tue, Aug 18, 2020 at 01:28:23PM +0200, Andrzej Pietrasiewicz wrote:
>> This is a follow-up of this thread:
>>
>> https://www.spinics.net/lists/linux-input/msg68446.html
> 
> lore.kernel.org is easier to pull stuff from :)
> 
> Anyway, what ever happened to this series?  Is there a newer one
> somewhere?
> 
> thanks,
> 
> greg k-h
> 

https://lkml.org/lkml/2020/8/18/440

Andrzej
