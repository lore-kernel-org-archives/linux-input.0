From: Kirill Smelkov <kirr@nexedi.com>
Subject: [PULL] stream_open bits for Linux 5.3
Date: Sun, 14 Jul 2019 14:13:45 +0000
Message-ID: <20190714141317.GA20277@deco.navytux.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <cocci-bounces@systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, cocci@systeme.lip6.fr, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-input@vger.kernel.org

Linus,

Please consider pulling the following stream_open related bits:

This time on stream_open front it is only two small changes:

- the first one converts stream_open.cocci to treat all functions that
  start with wait_.* as blocking. Previously it was only wait_event_.*
  functions that were considered as blocking, but this was falsely
  reporting deadlock cases as only warning. The patch was picked by
  linux-kbuild and already entered your tree as 0c4ab18fc33b.
  It is thus omitted from hereby pull-request.

- the second one teaches stream_open.cocci to consider files as being
  stream-like even if they use noop_llseek. I posted this patch for
  review 3 weeks ago[1], but got neither feedback nor complaints.

  [1] https://lore.kernel.org/lkml/20190623072838.31234-2-kirr@nexedi.com/


The changes are available for pulling from here:

	https://lab.nexedi.com/kirr/linux.git stream_open-5.3


Thanks beforehand,
Kirill


Kirill Smelkov (1):
      *: convert stream-like files -> stream_open, even if they use noop_llseek

 drivers/hid/hid-sensor-custom.c          | 2 +-
 drivers/input/mousedev.c                 | 2 +-
 scripts/coccinelle/api/stream_open.cocci | 9 ++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)
