From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Circular synaptics pads
Date: Sun, 25 Mar 2007 01:27:34 -0400
Message-ID: <200703250127.35272.dtor@insightbb.com>
References: <20070324042708.GA14593@srcf.ucam.org> <20070324043312.GB14593@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070324043312.GB14593@srcf.ucam.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Matthew,

On Saturday 24 March 2007 00:33, Matthew Garrett wrote:
> Ah, ignore that - it is in fact defined in the model ID field (should 
> have read the specs more closely first!) - if bits 0-3 equal 0x02, then 
> the pad is oval rather than rectangular (which matches the dumps I have 
> access to). So, the remaining question is how should this be exported to 
> userspace? In terms of interpreting scrolling, it's helpful for the 
> driver to know that the pad is circular.
> 

Would something like below do (untested)?

-- 
Dmitry


Input: synaptics - export model bits

Encode synaptics model in psmouse->model so it will be
exported via sysfs as input_dev->id.version and become
visible for applications.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/synaptics.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: work/drivers/input/mouse/synaptics.c
===================================================================
--- work.orig/drivers/input/mouse/synaptics.c
+++ work/drivers/input/mouse/synaptics.c
@@ -655,6 +655,16 @@ int synaptics_init(struct psmouse *psmou
 
 	set_input_params(psmouse->dev, priv);
 
+	/*
+	 * Encode touchpad model so that it can be used to set
+	 * input device->id.verssion and be visible to userspace.
+	 * Because version is __u16 we have to drop something.
+	 * Hardware info bits seem to be good candidates as they
+	 * are documented to be for Synapticss corp. internal use.
+	 */
+	psmouse->model = ((priv->model_id & 0x00ff0000) >> 8) |
+			  (priv->model_id & 0x000000ff);
+
 	psmouse->protocol_handler = synaptics_process_byte;
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
