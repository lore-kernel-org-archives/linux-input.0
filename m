From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: bug in evdev_disconnect
Date: Fri, 27 Apr 2007 15:07:39 -0400
Message-ID: <d120d5000704271207t3b86d32fu88f438fe3efbc612@mail.gmail.com>
References: <1177683991.3565.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1177683991.3565.8.camel@johannes.berg>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Hi Johannes,

On 4/27/07, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Obviously there's a use-after-free condition, but I can't really make
> out where it is. The disassembly seems to point to
>                list_for_each_entry(list, &evdev->list, node)
>                        kill_fasync(&list->fasync, SIGIO, POLL_HUP);
> in evdev_disconnect.
>
> Has somebody seen this before? It seems to happen only if userspace has
> the device open or so.
>

Please try -mm, it should be fixed there. As a temporary work wround
you can also swap list_for_each() and wake_up_interruptible() in
evdev_disconnect().

-- 
Dmitry
