From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: [PATCH v2 2/2] input: rotary-encoder: Add 'on-each-step' to binding documentation
Date: Fri,  4 Oct 2013 09:53:23 -0300
Message-ID: <1380891203-17617-3-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1380891203-17617-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380891203-17617-1-git-send-email-ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

The driver now supports a new mode to handle the interruptions generated
by the device: on this new mode an input event is generated on each step
(i.e. on each IRQ). Therefore, add a new DT property, to select the
mode: 'rotary-encoder,on-each-step'.

Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
---
I'm not at all happy with this DT binding as it's way to customized
for the current driver. For instance, if we want to support mapping
key events (or better arbitrary linux-input event types) it seems
there's no easy way to fix the binding.

Maybe a better way of handling the different 'modes' is through
compatible strings?

I'm not really sure, so I hope the DT guys have some comment on this.

 Documentation/devicetree/bindings/input/rotary-encoder.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index 3315495..b89e38d 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -15,6 +15,7 @@ Optional properties:
 - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
   greater than the specified steps or smaller than 0. For absolute axis only.
 - rotary-encoder,half-period: Makes the driver work on half-period mode.
+- rotary-encoder,on-each-step: Makes the driver send an event on each step.
 
 See Documentation/input/rotary-encoder.txt for more information.
 
-- 
1.8.1.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
