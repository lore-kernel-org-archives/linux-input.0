From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Fix locking in mousedev
Date: Fri, 9 Mar 2007 09:28:49 -0500
Message-ID: <d120d5000703090628p46556d52qb94b523fda4e947d@mail.gmail.com>
References: <20070228110631.86a150e4.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070228110631.86a150e4.zaitcev@redhat.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Pete,

On 2/28/07, Pete Zaitcev <zaitcev@redhat.com> wrote:
> If a process is closing /dev/input/mice and an mouse disconnects simulta-
> neously, the system is likely to oops. This usually happens when someone
> hits <Alt><Ctrl>F1 or logs out from X, and flips a KVM while the system
> is reacting.
>
> I reproduced the issue by running this:
>  while true; do cat </dev/null >/dev/input/mice; done
> This way, it oopses on 2nd or 3rd disconnect reliably. With the patch,
> I can disconnect the mouse 20 times.
>
> Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
>
> ---
>
> Discussion
>
> One of the race scenarios is related to the list of handles. The cat
> calls mousedev_close -> mixdev_release, does list_for_each to walk for
> all handles for a given handler. Iterations are longish while it does
> input_close_device -> hidinput_close -> usbhid_close -> usb_kill_urb,
> which sleeps briefly. Into this gap goes khubd and does hid_disconnect ->
> hidinput_disconnect -> input_unregister_device. This corrupts the list
> of handles which cat process is walking.
>
> I was unable to devise a scheme to protect the stock h_list adequately,
> so I implemented a private list of mousedev instances, which can be
> protected correctly.
>
> Dmitry, please consider getting rid of the list of handles entirely.
> The other major user is drivers/char/keyboard.c.
>

I agree that handlers should not access h_list nad use their own
private lists instead. However input core still needs that list to
maintain its books.

> Other than that, the patch is straightforward. It adds a static mutex
> to guard common data structures. It has to be static because instances
> of mousedev share common structures, such as the mousedev_table[].
>
> This should be uncontroversial, but please let me know if I missed
> something obvious.
>

I agree with the patch, unfortunately in lands squarely in the middle
of me restructuring the code (swiitch to struct device, proper
refcounting, etc) but I will try to adopt it.

-- 
Dmitry
