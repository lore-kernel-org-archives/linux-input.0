From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [v2] synaptics: match PNP-Id is not sufficient for min/max quirks
Date: Tue, 27 Jan 2015 17:36:00 +0100
Message-ID: <54C7BE70.7000802@redhat.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com> <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbbA0QgL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 11:36:11 -0500
In-Reply-To: <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <daniel.martin@secunet.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

On 01/27/2015 09:34 AM, Daniel Martin wrote:
> Hi,
>
> this is the second version of my patches to address the problems
> described at:
>      https://bugzilla.kernel.org/show_bug.cgi?id=91541
>
> I have incorporated changes according to Hans comments. That means I
> removed the patch
>      Input: synaptics - Add PnP id for X1 Carbon 1nd
> as the PnP id doesn't belong into the list topbuttonpad_pnp_ids and in
> the first patch
>      Input: synaptics - Split synaptics_resolution(), query ...
> I removed the SYN_ID_MAJOR() major check.

Patch set looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

> Is there anything else I should change?

That is up to Dmitry, btw when sending input patches you should send
them directly to Dmitry with the list in the Cc, I've added Dmitry to
the Cc now.

Regards,

Hans
