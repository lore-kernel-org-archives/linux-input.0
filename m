From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: trackpoint - force 3 buttons if 0 button is
 reported
Date: Fri, 12 Jan 2018 10:18:30 -0800
Message-ID: <20180112181830.ccpkltghgkj3oh3e@dtor-ws>
References: <20180112064658.25019-1-aaron.ma@canonical.com>
 <20180112083940.p36qj6ltzzwtuhng@dtor-ws>
 <06bbeca0-8a90-8935-9be3-f154db0b9fe9@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:41106 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964867AbeALSSd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 Jan 2018 13:18:33 -0500
Content-Disposition: inline
In-Reply-To: <06bbeca0-8a90-8935-9be3-f154db0b9fe9@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Aaron,

On Fri, Jan 12, 2018 at 08:45:17PM +0800, Aaron Ma wrote:
> Only this laptop had been confirmed is ALPS: 0102 – FF02 trackpoint, it
> return 0 of extended button.
> I saw the other device that returned 0, but don't have it now, so the ID
> can not be checked.
> 
> ThinkPad always have 3 buttons installed, I suggest always set 0x33 for
> button info when the button info returned 0.

I am really uncomfortable at us chipping away all validations in
trackpont protocol. The newer trackpoints (Elan, ALPS, etc) will be
taken care of with my patch that will not even try to fetch extended
button data for 0x02 - 0x04 extended ID devices, but unless we have a
concrete example of 0x01 responding with 0 for button info I will not
apply this patch.

Thanks.

-- 
Dmitry
