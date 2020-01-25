Return-Path: <SRS0=vq/H=3O=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA0C2D0CE
	for <linux-input@archiver.kernel.org>; Sat, 25 Jan 2020 01:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310992075D
	for <linux-input@archiver.kernel.org>; Sat, 25 Jan 2020 01:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZZ3UTU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbgAYBB4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:01:56 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:41724 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387475AbgAYBB4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Jan 2020 20:01:56 -0500
Received: by mail-pg1-f182.google.com with SMTP id x8so1985252pgk.8;
        Fri, 24 Jan 2020 17:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LkUPWh5kdl4Sg46sJyfitt6HLC6I557q2490DP7qh3M=;
        b=dZZ3UTU4UOOlw606J6+uj+IkABJEPApFTlmhcoT0n6lu9OHkz1ziZqvbJNTEOebkaM
         ZzwKG1IUL3AZK07M1F8Qg8B7BMwaN3SQoCvy9nirCrzrEs2utFvaXKht5HdttlldovxP
         Hc2mgCFGckAiybUbdH1zq88owtW8V3rqT6rAxoxUKNwt9uGUy+t7fz2JO2zs7p4cz8lg
         KEcylnv9u56hg9zEZf5LvQfRhGsMT4KX5Q/oev9cQl9r8OuDid18rVmaAtqqNrDK3d/C
         wWEC7cuFKOu2hVfV7vOpj37Qox77SkqbZ9PhGGk+1+EmG/RPZwGgFgxDKJGAyXHHXJKH
         HDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LkUPWh5kdl4Sg46sJyfitt6HLC6I557q2490DP7qh3M=;
        b=goaZj5OzRgnU+bQUKj69FhK++CIFOp83aN+LeJRDDaNvTCc26Pol0lq9XiHsO6wcVp
         QYlLFjZUr1BxVLDlGVjVaRZMHJ/JMj6ndfx+zrG175TxlpBwhkDR+PXqECptIuGI4UgO
         xuT7fQGblMeV/QWb3sGJQEXomAdKxBdq4GV3F79TidUxyhHUl1nxP954Vnat6vlDUfFH
         3n/Kw8nSx0vI8zulERIfWAfCK5/HgVHRkq8q2wWTl7S0bqpsDjMgvm1VZ7fksfpqcBYt
         SglAR0u4znwCy6Q0ln0jvOcTiAHj55Nmxrzem71rl/tRFVL8XLBwo5vJ10EFHHG370na
         Q6yw==
X-Gm-Message-State: APjAAAXT+3x+WoP7mosKqgRuBJNuwR6Y2FyFeIJkoiwiyIMYd61XyP7C
        rp4aEP+oK3ZFYivFkoW3RrU=
X-Google-Smtp-Source: APXvYqxDiDA5+kIDCFhEfVFU67Utzivxc1wCtaT/Q51DKRn9CC1Bi7/2Z2qQ9hNsj+8hA331vUjfzw==
X-Received: by 2002:a63:d047:: with SMTP id s7mr6922468pgi.81.1579914115234;
        Fri, 24 Jan 2020 17:01:55 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c184sm7662382pfa.39.2020.01.24.17.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 17:01:54 -0800 (PST)
Date:   Fri, 24 Jan 2020 17:01:52 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.5-rc7
Message-ID: <20200125010152.GA14053@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will receive:

- patches adding sanoty checks to USB endpoints in various dirvers
- max77650-onkey was missing a OF table which was preventing module
  autoloading
- a revert and a different fix for F54 handling in Synaptics dirver
- a fixup for handling register in pm8xxx vibrator driver.

Changelog:
---------

Bartosz Golaszewski (1):
      Input: max77650-onkey - add of_match table

Chuhong Yuan (1):
      Input: sun4i-ts - add a check for devm_thermal_zone_of_sensor_register

Hans Verkuil (2):
      Revert "Input: synaptics-rmi4 - don't increment rmiaddr for SMBus transfers"
      Input: rmi_f54 - read from FIFO in 32 byte blocks

Johan Hovold (8):
      Input: pegasus_notetaker - fix endpoint sanity check
      Input: aiptek - fix endpoint sanity check
      Input: aiptek - use descriptors of current altsetting
      Input: gtco - fix endpoint sanity check
      Input: gtco - fix extra-descriptor debug message
      Input: gtco - drop redundant variable reinit
      Input: sur40 - fix interface sanity checks
      Input: keyspan-remote - fix control-message timeouts

Miles Chen (1):
      Input: evdev - convert kzalloc()/vzalloc() to kvzalloc()

Stephan Gerhold (1):
      Input: pm8xxx-vib - fix handling of separate enable register

Diffstat:
--------

 drivers/input/evdev.c                    |  5 +---
 drivers/input/misc/keyspan_remote.c      |  9 ++++---
 drivers/input/misc/max77650-onkey.c      |  7 ++++++
 drivers/input/misc/pm8xxx-vibrator.c     |  2 +-
 drivers/input/rmi4/rmi_f54.c             | 43 ++++++++++++++++++++------------
 drivers/input/rmi4/rmi_smbus.c           |  2 ++
 drivers/input/tablet/aiptek.c            |  8 +++---
 drivers/input/tablet/gtco.c              | 13 +++-------
 drivers/input/tablet/pegasus_notetaker.c |  2 +-
 drivers/input/touchscreen/sun4i-ts.c     |  6 ++++-
 drivers/input/touchscreen/sur40.c        |  2 +-
 11 files changed, 59 insertions(+), 40 deletions(-)

Thanks.


-- 
Dmitry
