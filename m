From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: [PATCH 1/6] Haptic: add haptic class
Date: Tue, 13 Oct 2009 13:35:47 +0300
Message-ID: <359ed6810910130335m45919d6ala921d4cbfa5a341a@mail.gmail.com>
References: <20091007061701.GA7567@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759421AbZJMKg5@vger.kernel.org>
In-Reply-To: <20091007061701.GA7567@july>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com
List-Id: linux-input@vger.kernel.org

On Wed, Oct 7, 2009 at 09:17, Kyungmin Park <kyungmin.park@samsung.com> wrote:
> New haptic class support.
> This class handles the haptic devices.

I'm wondering why a haptic class is needed when there is force
feedback support. Admittedly, I don't know the force feedback
implementation too well, but could someone please enlighten me on
this? Am I missing something here?

I see haptics as simple force feedback, just with (usually) small
force and short duration. There are devices out there doing haptics
using vibra motors, which I think would be limited if implemented
using this haptics class driver. Would it be somehow problematic
interfacing with the simple haptic hardware using the force feedback
API?

BR,
Jani.
