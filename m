Return-Path: <SRS0=Zkgr=ZO=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53223C432C0
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 23:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126BB20672
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 23:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1V3l79W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVXXY (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:23:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44592 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVXXY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Nov 2019 18:23:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so4224468pfn.11;
        Fri, 22 Nov 2019 15:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pvYOCrt3MXfUyMaIjQihoVEJAi/1Rn5eAPOAfOzVHBQ=;
        b=t1V3l79WURdNYgb8NqAkAUQzHa8x1sGBg43xRYIPjvGLa91D37p6dvncu5FibqbREK
         CyoPIxiVUBmBuFNzQYpZCZcc59vdUSp3MoNXsoD5Pjt4ZGNa0gAaZrLUOLRxBdK34EYu
         zIqm3ZlSKLZCdPYuhOrxbkdgZyn+mA0Uc5QEc+S15SVA+PlkBvfrW65tBDFJ5tw6v697
         l8asnl53kyLJXCcQhJSfs9YhkqYwMMElyDZkCc2/iolUZSZrjbFIZHzQHER8if1+zlVz
         HQbkF5Uk8YH/fDMWIOUZddT1CkAreh5i5hiofKyHGk/l4+R1OLCSJKzQFwpFEPpkff8z
         XEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pvYOCrt3MXfUyMaIjQihoVEJAi/1Rn5eAPOAfOzVHBQ=;
        b=mzxBbYAbogDKbwn5RnphILP7y8CLlBwF97uOJEY9z7XGirNBgN4Kf0w60tNN8Wm9pF
         /3XnWYZ1yfUNJE4DmVxsn+tq7CaKO9qIG1cEoMB6Dh+oPnlyWLQbEYv9uGjmH81i1WeU
         eAA+4Vdd7YgGwQSYKvqOq1g8mNbdwURuIdeItDXrNW79cO2eMznzBBn9U58HUpbURncK
         UKRwGI56IxTdHxfpqg1QYwLih/XL7HZ02M7K6807nv6xJyfpvYy0MlQFXOMB1j9v/9In
         LJpytOerZy+cbrxx+liVTMxrEDwISzkuVKYdOoHp2/Q3yAFqofRu4o9CSPpheLBKIZM2
         AXMA==
X-Gm-Message-State: APjAAAWbHTC6xxR19CLlalm2HVazkTUazRvDAwEjBbR/R9VqGhW9KW9+
        5O5idGj4OYcAFZ6Kp6fAMYg=
X-Google-Smtp-Source: APXvYqziHF2tz/o/6imDkZRMuFN0g2Pccb1rSLA8CdwHVQoo/9WBl6pwB9fR4+9cYxWELSvMYKTS+w==
X-Received: by 2002:a63:ce12:: with SMTP id y18mr17854691pgf.186.1574465003221;
        Fri, 22 Nov 2019 15:23:23 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u7sm4054362pjx.19.2019.11.22.15.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:23:22 -0800 (PST)
Date:   Fri, 22 Nov 2019 15:23:20 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.4-rc8
Message-ID: <20191122232320.GA37127@dtor-ws>
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

to receive updates for the input subsystem. Just a single revert as RMI
mode should not have been enabled for this model [yet?]

Changelog:
---------

Lyude Paul (1):
      Revert "Input: synaptics - enable RMI mode for X1 Extreme 2nd Generation"

Diffstat:
--------

 drivers/input/mouse/synaptics.c | 1 -
 1 file changed, 1 deletion(-)

Thanks.


-- 
Dmitry
