From: Christopher Head <chead@chead.ca>
Subject: Re: [PATCH] HID: input: fix confusion on conflicting mappings
Date: Wed, 7 Jan 2015 21:50:04 -0800
Message-ID: <20150107215004.2f3f748a@kruskal.home.chead.ca>
References: <20141230165739.050cc0b9@kruskal.home.chead.ca>
	<CAMsZVf_UT+m_8BWqz0+aYGJB+8Z_u6xRU7efLZ-Bd7WNhn4ZYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from chead.ca ([162.250.190.135]:34462 "EHLO chead.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbbAHFuJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jan 2015 00:50:09 -0500
In-Reply-To: <CAMsZVf_UT+m_8BWqz0+aYGJB+8Z_u6xRU7efLZ-Bd7WNhn4ZYA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fredrik Hallenberg <megahallon@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Tue, 6 Jan 2015 13:37:26 +0100
Fredrik Hallenberg <megahallon@gmail.com> wrote:

> ...
>     if (!(field->flags & (HID_MAIN_ITEM_RELATIVE |
>                   HID_MAIN_ITEM_BUFFERED_BYTE)) &&
>         (field->flags & HID_MAIN_ITEM_VARIABLE) &&
>         usage->usage_index < field->maxusage &&
>         value == field->value[usage->usage_index]) {
> ...

This works perfectly for me, thanks.
-- 
Christopher Head
