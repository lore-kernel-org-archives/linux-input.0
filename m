Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EC0C63798
	for <linux-input@archiver.kernel.org>; Thu, 26 Nov 2020 15:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E370B21D40
	for <linux-input@archiver.kernel.org>; Thu, 26 Nov 2020 15:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=illis-uk.20150623.gappssmtp.com header.i=@illis-uk.20150623.gappssmtp.com header.b="cgN3JYf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgKZP6N (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 26 Nov 2020 10:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391515AbgKZP6N (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Nov 2020 10:58:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659CFC0613D4
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2020 07:58:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 23so2646642wrc.8
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2020 07:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illis-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=EHJ99iwOwoJNZyC/JnBicu6sU+Vilg7bnikR0qxNTnA=;
        b=cgN3JYf9hhJPHdhw54BrKfbgNTfWs14/Fh7vAPdfcgwdV7AeqduqUh9cbGbq9twewQ
         qEpUbQBVLR12VIjkY6FLm+TpIR4OE0EOhGBwiVJs+tkLKk5G1pOyKA9txBoMOOEbNED9
         yUDedIswUQ0f8bF13rOF13ZvOwWcMhHI+H+ofeNoG4zkof/zfZf07QqvNVHZn7zGKeZU
         BQcjDupQ9rYFdZkbpwIsg8VeoLtDLR7EbZw6jyR+Nh//8nQI7zRiaAzQq9lIvpUfvFOY
         uouGWmNzirMKNRN116Theo3X8bcIyr1CdgjNuEpRe1PNdZJMGpmk+YEMjj7W0nAi+/WC
         wnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EHJ99iwOwoJNZyC/JnBicu6sU+Vilg7bnikR0qxNTnA=;
        b=lnEra/oW2syrxZ1pazkGvPGXPr2kMVZWbK3XZWYjdTM6xylHcXbjyvrsWm4/q8UtcY
         ZTmoCt6TThUs0yLFG8MO698b61uOD9czDdYAB5yRG9qHSzEdM1BrWc+1kEDCsgli5dOv
         V9IXecjbtRdhwARce8eTNGalxJvQNbL4rS4WZkLRmBhLcKaQEjQOiXOymnZDf8A927Sj
         9LDOUS09GZQ4WLA/lQBNt4n+mV8DeEDExAHXo+/Rv7iZHMJFawQFjBPS+lKVSerTClma
         RcS+II+9pQhdULBs7xaJcMdg5r/Tkdckqj26XuXsWogZrmgrFRjaaX7FgQW2tofc1Zzb
         VyLw==
X-Gm-Message-State: AOAM532rCkHgJoWPwlZNvvSL62SnoP11zpfKlvWQbGVsnw3VdVRZceIF
        on8fDplIqGLQnLvy266uMn4ngve6CA+3dJ71wE7bYz5KIrQEGiwqvOA=
X-Google-Smtp-Source: ABdhPJwmby1zjkHLiBR6GM8Q5aeWGeBQ/3yilXqZ3wSYqTFnxUDGJgyIYomYLay4dXw+spu67IwSetGrNZVQdnVqbqI=
X-Received: by 2002:adf:e88b:: with SMTP id d11mr4680279wrm.4.1606406289997;
 Thu, 26 Nov 2020 07:58:09 -0800 (PST)
MIME-Version: 1.0
From:   Max Illis <max@illis.uk>
Date:   Thu, 26 Nov 2020 15:57:59 +0000
Message-ID: <CAA5fPw=5SJvsYjoZDECAhHDe5XeLt-HmEvMrmgaeJ7hQMwHnRg@mail.gmail.com>
Subject: Support for Logitech g703 mouse battery levels
To:     linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

I raised a ticket on upower, but have been pointed here
(https://gitlab.freedesktop.org/upower/upower/-/issues/125)

_Some_ info is reported:

```
/sys/class/power_supply/hidpp_battery_1$ ls
device  manufacturer  online  powers  serial_number  subsystem  uevent
      wakeup27
hwmon3  model_name    power   scope   status         type       voltage_now
```
But nothing is reported by upower apparently due to `capacity` or
`capacity_level` missing

I'm running Ubuntu 20.10 Linux 5.8.0-29-generic

LMK if more info is needed
Max

max@illis.uk
07803 009 004

max@illis.uk
07803 009 004
