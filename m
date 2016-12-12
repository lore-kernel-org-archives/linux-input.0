From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Mon, 12 Dec 2016 09:53:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612120951130.16984@cbobk.fhfr.pm>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org> <20161201143434.GD1280@mail.corp.redhat.com> <20161201172448.GA46688@google.com> <20161205235908.rmiyd7io4kddple6@rob-hp-laptop> <20161206084803.GR1280@mail.corp.redhat.com>
 <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com> <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com> <20161208154145.GA30888@mail.corp.redhat.com> <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com> <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com> <alpine.LNX.2.00.1612091532240.16984@cbobk.fhfr.pm> <CAL_JsqLpjhHeeKq3PmNToux1Rgkg0M84-dv9HGCOws223ima4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLpjhHeeKq3PmNToux1Rgkg0M84-dv9HGCOws223ima4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

Given the timing (merge window being open) and given then NACK given by 
Rob, I've now unapplied the patches (the for-4.10/i2c-hid branch is now 
obsolete, and has been superseded by for-4.10/i2c-hid-nopower).

However, this is mostly done in order to provide more time for discussion; 
I still disagree with the reasoning behind the NACK.

-- 
Jiri Kosina
SUSE Labs
