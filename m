From: Christian Lamparter <chunkeey@googlemail.com>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Wed, 17 Feb 2010 19:43:56 +0100
Message-ID: <22ee4e771002171043u2aaf97vd73c1090c2fce901@mail.gmail.com>
References: <1266356185-10324-1-git-send-email-mjg@redhat.com>
	 <20100217052247.GD7160@core.coreip.homeip.net>
	 <20100217180342.GA22522@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:64131 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab0BQSn7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 13:43:59 -0500
In-Reply-To: <20100217180342.GA22522@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, johannes@sipsolutions.net, linux-wireless@vger.kernel.org, linux-input@vger.kernel.org, marcel@holtmann.org

On Wed, Feb 17, 2010 at 7:03 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Feb 16, 2010 at 09:22:47PM -0800, Dmitry Torokhov wrote:
>
>> I'd like some breathing room aroung KEY_NUMERIC? Any issues with making
>> it 247 or 0x211?
>
> None. Do you want to make that change, or should I resubmit?
>
Wait wait... do you can get another KEY_?

The reason: Some new devices come with a WPS "Push Button".
And there's no code for them yet.

Regards, Chr.
