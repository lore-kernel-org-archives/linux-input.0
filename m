From: Edgar Simo <bobbens@gmail.com>
Subject: Force Feedback Comments
Date: Sun, 20 Jul 2008 19:28:01 +0200
Message-ID: <488375A1.2020109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:32166 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757638AbYGTR2G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2008 13:28:06 -0400
Received: by ug-out-1314.google.com with SMTP id h2so189954ugf.16
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2008 10:28:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,


I'm working on developing a cross-platform API for doing force feedback.
 I've noticed some lacking features which other OS (in this case Mac OS
X and Windows) seem to have and would like to see if they could be
implemented:

   * Effect Status - Be able to query whether or not an effect is
playing on a device.  Linux equivalent of Mac OS X FFEffectGetEffectStatus.

   * Pause/Stop/Disable Device - Allow pausing/resuming/stopping all the
effects on a device at the same time.  Also allow disabling/enabling of
actuators or reseting the device.  Analogous to Mac OS X
FFDeviceSendForceFeedbackCommand.  While I see the pause/resume/stop as
pretyt feasible, the disabling actuators would be more complicated
unless you do that in software (would have to reverse engineer).

  * Get maximum effects playing at the same time - Currently there only
is EVIOCGEFFECTS which returns the number of effects the device can keep
in memory (Documentation/ff.txt is right, while linux/input.h is wrong
about this).

  * Check device state - While not really needed, I'm just adding it
here for the sake of completion.  Would let you see if the device is
paused, has actuators disabled, is empty, not powered, safety switch on,
etc...  Similar to Mac OS X FFDeviceGetForceFeedbackState.


Things I've noticed that are wrong/missing:

   * The ff_trigger doesn't seem to work (tested with the Rumblepad 2).
 I've tried uploading the effect and pressing the button and running it.
 If you run the effect it just plays normally.  I'm assuming that you
just need to upload it and it'll work automatically.  A bit lost with this.

   * Condition effects have no envelope - I really don't know the reason
about this.  As far as I can see condition effects on other systems do
use the envelope, but maybe I'm wrong.

   * Condition effects use only and always two axis.  I have yet to see
a three axis controller (not even really sure what I'm looking for), but
what is the reason behind this?  Windows and Mac OS X API make you set
the number of axes you want to use and which ones you want to use then
work with those.  Not really sure about the reason behind this, but I'm
guessing it's because there really only are two axis controllers
(joysticks) while the fancier ones (ex: Novint Falcon) use weirder API.
  Also how does the direction interact with this?  In Mac OS X if you
use more then one axis you must send data individually to each axis, but
if you only define one axis you can use the direction. Any ideas on this?


Overall the linux force feedback API seems a bit rough around the edges,
and not many people seem to use it.  I'm hoping to change this with my
cross platform force feedback api.  It's great to see it working and the
API is much nicer to use overall then the Mac OS X and Windows equivalents.

Thanks,


Edgar
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiDdaEACgkQolm4VNX3QTyc6QCeIqalOeur/BCaRfZhkxUHxUf1
WO4AmQGPZnQuHhiNNSPvC5VCcpYRlbfp
=2MJi
-----END PGP SIGNATURE-----
