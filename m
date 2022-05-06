Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08561C433EF
	for <linux-input@archiver.kernel.org>; Fri,  6 May 2022 10:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359422AbiEFKHs (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 6 May 2022 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiEFKHs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 May 2022 06:07:48 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B80E5A2D5
        for <linux-input@vger.kernel.org>; Fri,  6 May 2022 03:04:05 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D30C0240012;
        Fri,  6 May 2022 10:04:02 +0000 (UTC)
Message-ID: <42bb6003dfa668b8829b8810bf97be2ba636857c.camel@hadess.net>
Subject: Re: [PATCH 1/1] HID: apple: Properly handle function keys on
 Keychron keyboards
From:   Bastien Nocera <hadess@hadess.net>
To:     Bryan Cain <bryancain3@gmail.com>, linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Fri, 06 May 2022 12:04:02 +0200
In-Reply-To: <20220505191221.36172-2-bryancain3@gmail.com>
References: <20220505191221.36172-1-bryancain3@gmail.com>
         <20220505191221.36172-2-bryancain3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

T24gVGh1LCAyMDIyLTA1LTA1IGF0IDEzOjEyIC0wNjAwLCBCcnlhbiBDYWluIHdyb3RlOgo+ICvC
oMKgwqDCoMKgwqDCoGlmIChmbm1vZGUgPT0gMykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZWFsX2ZubW9kZSA9IChhc2MtPnF1aXJrcyAmIEFQUExFX0lTX0tFWUNIUk9OKSA/
IDIgOgo+IDE7Cj4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmVhbF9mbm1vZGUgPSBmbm1vZGU7Cj4gK8KgwqDCoMKgwqDCoMKgfQoKV291
bGRuJ3QgaXQgYmUgd29ydGggYWRkaW5nIGFuIGVudW0gZm9yIHRob3NlIHZhbHVlcz8gKHdoZW4g
dGhlCmNvbmZpZ3VyYXRpb24gd2FzIGFkZGVkIHdvdWxkIGhhdmUgYmVlbiBhIGJldHRlciB0aW1l
LCBidXQgdGhlIHNlY29uZApiZXN0IHRpbWUgdG8gZG8gaXQgd291bGQgYmUgbm93IDspCg==

