From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] hid: microsoft: Add rumble support for Xbox One S
 controller
Date: Fri, 10 Aug 2018 13:38:01 +0200
Message-ID: <ad932296a864b13134c5af6efe7754e5e588314e.camel@hadess.net>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810001714.14659-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Juha Kuikka <juha.kuikka@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, 2018-08-09 at 17:17 -0700, Andrey Smirnov wrote:
> Add HID quirk driver for Xbox One S controller over bluetooth.
> 
> This driver only adds support for rumble. Standard controller
> functionality is exposed by default HID driver.

Did you manage to make the joypad work without hacks in the Bluetooth
stack[1]?

[1]: https://github.com/ValveSoftware/steamos_kernel/commit/549c3dc10fa3749b3999549a2672b14bf0e9786d
