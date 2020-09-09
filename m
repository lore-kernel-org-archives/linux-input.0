Return-Path: <SRS0=+NLB=CS=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B5DC43461
	for <linux-input@archiver.kernel.org>; Wed,  9 Sep 2020 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1302121D7E
	for <linux-input@archiver.kernel.org>; Wed,  9 Sep 2020 22:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nncUTurk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIIWcA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIIWb6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2020 18:31:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A2EC061756
        for <linux-input@vger.kernel.org>; Wed,  9 Sep 2020 15:31:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so2057240pjb.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2020 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtoAvOurFFZP/gUt2lOxm9is7YQr4gyUFJI+eCbp8z4=;
        b=nncUTurk+QTmh61R5oSwO5R5vYFaOtQwsoT1xsoDlKIM4Bisb51TEz43D09Ty9brUU
         EeE2JTcVrDeGt/IOKdBZAku5MwinwMy0rXaXhTuJrZNDBT5oNPlMwdlCn06bzjj7WdNW
         fc3JeZEvrCgrQTn8CjWa7r01EYq0SAsqNE8Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtoAvOurFFZP/gUt2lOxm9is7YQr4gyUFJI+eCbp8z4=;
        b=WIeowmJyl9om8QIe4MKybPFNfL73yTUcRjlzmg6qc3UWww4qvkEt/A5JG/paBxCI15
         Vl6YUaJko9WmimC2w6Ida/vpLH2IqouEZlGKWMikv9zEFPwlvWQHNEZIvCs/spIC4IcZ
         1kQ8MvtYIW0EaRTszKbapAlJe7UI1N9XIDNqbkCYp/t/iOzRcQUxAqDcvFq0JeIkUPGK
         +k9lHkQvgSG0ibkRwKsJucIuglBMfvYUX2mraca4z1JW2xHtQDjsT7Rjq9x2SFQPxZfM
         wVTIrQDBBT8J3gJNvA94SiG3rOK2fezcUwJhPQi+axPeKCkEmMwHzm+6XMRPdFgDVu7i
         oT3A==
X-Gm-Message-State: AOAM5327/TErBkxbzbzgydWJZYjGGCLRmjg8QucPMIU+ZIT44GglIaGt
        6dTyAeDaGhJDBkGda7g8uJ66KA==
X-Google-Smtp-Source: ABdhPJyd/8VUFRrDN1AM3yMkWgUakcKJSafwNXibEDC+aIZz/Pj9EACZVIkCAEUcPwVPr9WZtbWqiQ==
X-Received: by 2002:a17:90b:a4b:: with SMTP id gw11mr2462960pjb.37.1599690717790;
        Wed, 09 Sep 2020 15:31:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9657:a5ff:feef:7b57])
        by smtp.gmail.com with ESMTPSA id u14sm3826433pfc.203.2020.09.09.15.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 15:31:57 -0700 (PDT)
From:   Sean O'Brien <seobrien@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sean O'Brien <seobrien@chromium.org>
Subject: Re: [PATCH v3] HID: add vivaldi HID driver
Date:   Wed,  9 Sep 2020 15:31:48 -0700
Message-Id: <20200909223148.419843-1-seobrien@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <ad58952a64bdf8e64bf4da5461db43c6a30d3b70.camel@perches.com>
References: <ad58952a64bdf8e64bf4da5461db43c6a30d3b70.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

> if ((parser->global.usage_page << 16) != HID_UP_GOOGLEVENDOR)
>	return;

I'm a bit worried about adding an early return, as it may cause issues
if someone doesn't notice when adding another case. Looking at this again
I can easily remove the second line break now that I've changed the group
name.
