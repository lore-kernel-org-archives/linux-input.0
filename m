From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v6] HID: sb0540: add support for Creative SB0540 IR
 receivers
Date: Tue, 03 Sep 2019 16:15:00 +0200
Message-ID: <2505a7c3e29afb5a140ed47e54ea9c72d0192367.camel@hadess.net>
References: <20190702083931.7392-1-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702083931.7392-1-hadess@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <bnocera@redhat.com>
List-Id: linux-input@vger.kernel.org

Hey,

On Tue, 2019-07-02 at 10:39 +0200, Bastien Nocera wrote:
> From: Bastien Nocera <bnocera@redhat.com>
> 
> Add a new hid driver for the Creative SB0540 IR receiver. This
> receiver
> is usually coupled with an RM-1500 or an RM-1800 remote control.
> 
> The scrollwheels on the RM-1800 remote are not bound, as they are
> labelled for specific audio controls that don't usually exist on most
> systems. They can be remapped using standard Linux keyboard
> remapping tools.

I'm back from travelling, so ready to update/respin this patch if
needed.

Cheers
