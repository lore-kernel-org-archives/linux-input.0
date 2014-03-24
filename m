From: Petri Gynther <pgynther@google.com>
Subject: Re: [PATCH] HID: uhid: Add UHID_CREATE2 + UHID_INPUT2
Date: Mon, 24 Mar 2014 12:19:44 -0700
Message-ID: <CAGXr9JEi8D1vrhOBk=M4my5hD9o+arUkR_52Hho60FrR9tz=-w@mail.gmail.com>
References: <20140319034501.4B61E10081C@puck.mtv.corp.google.com>
	<CANq1E4SKtB3+pQas9NVE93yVJAArc=LB1r2ojTgE=33YzRnDiw@mail.gmail.com>
	<CAGXr9JHyR30ZkwnqMvJeSNGurUHFAAsbw7WB85TyaoSjgjrr8Q@mail.gmail.com>
	<CANq1E4QnrBxjuK9irmHss54hJi9T=u0WidB2o=8a1r=2Jo-JuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:59240 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbaCXTTp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Mar 2014 15:19:45 -0400
Received: by mail-ve0-f170.google.com with SMTP id pa12so6289297veb.15
        for <linux-input@vger.kernel.org>; Mon, 24 Mar 2014 12:19:44 -0700 (PDT)
In-Reply-To: <CANq1E4QnrBxjuK9irmHss54hJi9T=u0WidB2o=8a1r=2Jo-JuA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi David,

On Mon, Mar 24, 2014 at 12:07 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Mon, Mar 24, 2014 at 8:04 PM, Petri Gynther <pgynther@google.com> wrote:
>> This won't be enough. For UHID_CREATE, we need to use
>> ev->u.create.<member> and for UHID_CREATE2, ev->u.create2.<member>.
>> But, I'll collect those in local variables up front, so we can have
>> just one handler function. I'll send the revised diff shortly.
>
> Oh right, In that case I think we can keep the two functions.

Agreed, I think we should keep the the two functions separate. So, is
the diff good as-is?

-- Petri

>
> Thanks
> David
