From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCH 2/3] devicetree: bindings: use input-event-codes.h for
 evdev codes
Date: Tue, 15 Sep 2015 12:24:52 +0100
Message-ID: <1442316292.3549.386.camel@hellion.org.uk>
References: <1442064372-3030-1-git-send-email-hdegoede@redhat.com>
 <1442064372-3030-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442064372-3030-3-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 2015-09-12 at 15:26 +0200, Hans de Goede wrote:
> Add a symlink to uapi/linux/input-event-codes.h, and include that instead
> of (re)defining all the evdev type and code values in
> dt-bindings/input/input.h. This way we do not need to keep all the
> event codes synced manually.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  include/dt-bindings/input/input-event-codes.h |   1 +
>  include/dt-bindings/input/input.h             | 510 +-------------------
> ------
>  2 files changed, 2 insertions(+), 509 deletions(-)
>  create mode 120000 include/dt-bindings/input/input-event-codes.h
> 
> diff --git a/include/dt-bindings/input/input-event-codes.h b/include/dt
> -bindings/input/input-event-codes.h
> new file mode 120000
> index 0000000..693bbcd
> --- /dev/null
> +++ b/include/dt-bindings/input/input-event-codes.h
> @@ -0,0 +1 @@
> +../../uapi/linux/input-event-codes.h
> \ No newline at end of file

Hrm, I think this is going to cause trouble for the split DT repository at
https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/

Since ../../ == include in both trees I think I can make it work by
including include/uapi/linux in the conversion, either wholesale (easiest)
or partially (potentially cleaner).

Any opinions on that?

In principal I ought to regenerate the tree from scratch such that
include/uapi/linux was "always" there and has history but I think we can
live with it just appearing at some point in time wen the conversion script
was updated?

AIUI these values are required to only be used with properties whose names
are of the form "linux,*", otherwise there would be strong complaints about
include Linux uapi stuff into a generic device-tree binding.

Ian.
