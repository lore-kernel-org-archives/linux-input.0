Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A01CDB483
	for <linux-input@archiver.kernel.org>; Fri, 13 Oct 2023 14:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjJMOyp (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 13 Oct 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjJMOyo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2023 10:54:44 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B88ABE;
        Fri, 13 Oct 2023 07:54:42 -0700 (PDT)
Received: from [10.6.0.9] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 2E6502FC0052;
        Fri, 13 Oct 2023 16:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1697208880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YUgetVycmc11Sy23hS1geccFjAg3uLc1PoJalbYEo1A=;
        b=J8AgwRiWLaST6rVU1SVH02DPcyjEHDLQmnv1X7wYEohahPt5H29XeiEg3p1zW4epN/5lA8
        38a2KpVUTqkiQTDFKHGdAXklNOvFXvojESrGFHqYNsqVMyrHokFyjBYqNsvqnsY9gBUm0j
        jJVGg9wR/zr874sLYF/SRnmHAmoTv9g=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
Date:   Fri, 13 Oct 2023 16:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Implement per-key keyboard backlight as auxdisplay?
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, ojeda@kernel.org
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-input@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
 <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

coming from the leds mailing list I'm writing with Pavel how to best handle 
per-key RGB keyboards.

His suggestion was that it could be implemented as an aux display, but he also 
suggested that I ask first if this fits.

The specific keyboard RGB controller I want to implement takes 6*21 rgb values. 
However not every one is actually mapped to a physical key. e.g. the bottom row 
needs less entries because of the space bar. Additionally the keys are ofc not 
in a straight line from top to bottom.

Best regards,

Werner

