From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [PATCH 4/5] HID: sony: Send ds4 output reports on output
 end-point
Date: Wed, 5 Oct 2016 11:35:39 -0600
Message-ID: <4f8de661a2a8be99ddcb284a89d4422c.squirrel@mungewell.org>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
    <1475636338-3779-5-git-send-email-roderick@gaikai.com>
    <20161005083150.GB19261@mail.corp.redhat.com>
    <5FB6ED86-613A-449C-8D7C-60FD136075C3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:33682 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755453AbcJERfp (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2016 13:35:45 -0400
In-Reply-To: <5FB6ED86-613A-449C-8D7C-60FD136075C3@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>, Frank Praznik <frank.praznik@oh.rr.com>, Simon Wood <simon@mungewell.org>, Antonio Ospite <ao2@ao2.it>

On Wed, October 5, 2016 10:54 am, Frank Praznik wrote:
> The best answer I can give is "not to my knowledge”.  Rumble and LEDs
> have standard kernel interfaces but obviously we can’t guarantee 100% that
> nobody is using hidraw directly.  Commercial games and engines aren't
> running as root and thus can’t use hidraw so I think we can safely say
> that no major commercial software will be broken by this.

There are a couple of projects I know of, but I am unable to say whether
they are still active or whether proposed changes will affect them...
https://thp.io/2010/psmove/
http://moveonpc.blogspot.ca/
https://github.com/chrippa/ds4drv

Audio output is one area of the DS4 which is not supported in kernel,
maybe some renewed interest can get this working.

I agree with Frank that we should move forward, if something gets broken
we can work a better solution.
Simon.

acked-by: Simon Wood <simon@mungewell.org>



