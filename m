Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F3AC433EF
	for <linux-input@archiver.kernel.org>; Wed, 29 Jun 2022 09:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiF2Jib (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2Jia (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Jun 2022 05:38:30 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6805822289;
        Wed, 29 Jun 2022 02:38:28 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id BBBEDCDF5A;
        Wed, 29 Jun 2022 09:31:43 +0000 (UTC)
Received: (Authenticated sender: sendmail@ipik.org)
        by mail.gandi.net (Postfix) with ESMTPSA id CFCC41C0014;
        Wed, 29 Jun 2022 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipik.org; s=gm1;
        t=1656495081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7n1ncJ+RgD1gQjuPUVKXfyucE9dYx9coqdYqvgdgAK0=;
        b=P3QWpIZeiiT5pVVU4KpeJVjxhUQHN7vKWt3YAqFuZsc7gUMAonYfCRU1qVYSuhW5vBqtjC
        Z3RBhJMgdx9vQLpFGwepPQw21JZiN/Pza/xKpbWrTkstckp9IemFDW3PJJpL/4eOeZ+jHa
        gzE9F2GpgjRHEioVx8cxJjoFgQldgK8Nmx1SKJk8lni8OShO12hqY1UJTR4/jGBeyMzLgj
        Q3H0oD1UnRdjqSBYsrEMocx9F8ckspxp4tYSb38a5dLQz/GqF5vItGXvK+ysLYJ5wY1cZ+
        WrsJtGNOP9cKCq/DjuU8fhLxgi1WROrgmrp5vjPPm6jsu2lR1kHAFsOCaoNnuw==
Message-ID: <ddc4f559-f03c-8d40-73a7-93d767b45bd6@ipik.org>
Date:   Wed, 29 Jun 2022 11:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To:     Jiri Kosina <jikos@jikos.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        dmitry.torokhov@gmail.com
Cc:     andrew.smirnov@gmail.com, enric.balletbo@collabora.com,
        kirr@nexedi.com, linux-bluetooth@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com, luiz.dentz@gmail.com, pali.rohar@gmail.com,
        tglx@linutronix.de, abhishekpandit@chromium.org
References: <20191127185139.65048-1-abhishekpandit@chromium.org>
Subject: Re: [PATCH] Input: uinput - Add UI_SET_UNIQ ioctl handler
Content-Language: en-GB
From:   macmpi <spam@ipik.org>
In-Reply-To: <20191127185139.65048-1-abhishekpandit@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi!

Bug 216134 has been been submitted on this issue 
https://bugzilla.kernel.org/show_bug.cgi?id=216134

Thanks for consideration and feedback.
