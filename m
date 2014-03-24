From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: uhid: Add UHID_CREATE2 + UHID_INPUT2
Date: Mon, 24 Mar 2014 20:07:45 +0100
Message-ID: <CANq1E4QnrBxjuK9irmHss54hJi9T=u0WidB2o=8a1r=2Jo-JuA@mail.gmail.com>
References: <20140319034501.4B61E10081C@puck.mtv.corp.google.com>
	<CANq1E4SKtB3+pQas9NVE93yVJAArc=LB1r2ojTgE=33YzRnDiw@mail.gmail.com>
	<CAGXr9JHyR30ZkwnqMvJeSNGurUHFAAsbw7WB85TyaoSjgjrr8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:45594 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbaCXTIr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Mar 2014 15:08:47 -0400
Received: by mail-ie0-f172.google.com with SMTP id as1so6056053iec.17
        for <linux-input@vger.kernel.org>; Mon, 24 Mar 2014 12:08:47 -0700 (PDT)
In-Reply-To: <CAGXr9JHyR30ZkwnqMvJeSNGurUHFAAsbw7WB85TyaoSjgjrr8Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Mon, Mar 24, 2014 at 8:04 PM, Petri Gynther <pgynther@google.com> wrote:
> This won't be enough. For UHID_CREATE, we need to use
> ev->u.create.<member> and for UHID_CREATE2, ev->u.create2.<member>.
> But, I'll collect those in local variables up front, so we can have
> just one handler function. I'll send the revised diff shortly.

Oh right, In that case I think we can keep the two functions.

Thanks
David
