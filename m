From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] HID:i2c-hid: add a simple quirk to fix device defects
Date: Thu, 10 Nov 2016 09:39:23 +0100
Message-ID: <20161110083923.GF10327@mail.corp.redhat.com>
References: <1478749633-28185-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754694AbcKJIj1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 03:39:27 -0500
Content-Disposition: inline
In-Reply-To: <1478749633-28185-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hn.chen@weidahitech.com
Cc: jkosina@suse.cz, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Nov 10 2016 or thereabouts, hn.chen@weidahitech.com wrote:
> From: HungNien Chen <hn.chen@weidahitech.com>
> 
> Rename i2c_hid_blacklist as i2c_hid_quirks.
> Make the syntax changes of macro & for_loop slightly.
> 
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
