From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Fix sudden warps in mousedev
Date: Mon, 26 Mar 2007 12:17:18 -0700
Message-ID: <20070326121718.3940a579.zaitcev@redhat.com>
References: <20070324001610.724a820a.zaitcev@redhat.com>
	<200703250134.03416.dtor@insightbb.com>
	<20070325111930.f6428509.zaitcev@redhat.com>
	<200703252319.39676.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200703252319.39676.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, zaitcev@redhat.com
List-Id: linux-input@vger.kernel.org

On Sun, 25 Mar 2007 23:19:38 -0400, Dmitry Torokhov <dtor@insightbb.com> wrote:

> I tried to reproduce warping on console but could not for some reason. Could you
> please try the patch below and tell me if it fixes the problem for you?

> +++ work/drivers/input/mousedev.c
> @@ -124,32 +124,33 @@ static void mousedev_touchpad_event(stru
> -				if (mousedev->pkt_count >= 2) {
> +			if (mousedev->touch && mousedev->pkt_count >= 2) {

This works, thanks a lot.

The double-indented switch() is annoying, but since the whole driver
is written to the same style, I can live with it, for the uniformity
purposes :-)

You can't imagine the relief of using a reliable pointer again, after
months of touching the pad with a certain trepidation.

-- Pete
