From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH V2 1/5] ASoC: core: Add component pin control functions
Date: Tue, 29 Nov 2016 15:44:38 +0000
Message-ID: <1480434282-26389-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35382 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757681AbcK2Poy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 10:44:54 -0500
In-Reply-To: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: broonie@kernel.org, cw00.choi@samsung.com, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

It's often the case that a codec driver will need to control its
own pins. However, if a name_prefix has been applied to this codec it
must be included in the name passed to any of the snd_soc_dapm_x_pin()
functions.

The behaviour of the existing pin control functions is reasonable, since
you may want to search for a fully-specified name within the scope of an
entire card. This means that we can't apply the prefix in these functions
because it will break card-scope searches.

Constructing a prefixed string "manually" in codec drivers leads to a lot
of repetition of the same code.

To make this tidier in codec drivers this patch adds a new set of
equivalent functions that take a struct snd_soc_component instead of a
dapm context and automatically add the component's name_prefix to the
given name. This makes it a simple change in codec drivers to be
prefix-safe.

The new functions are not quite trivial enough to be inlines and the
compiler won't be able to compile-away any part of them.

Although it looks somewhat inefficient to have to allocate a temporary
buffer and combine strings, the current design of the widget list
doesn't lend itself to a more optimized implementation - it's a single
list of all widgets on a card and is searched linearly for a matching
string. As pin state changes are generally low-frequency events it's
unlikely to be a significant issue - at least not enough to rewrite the
widget list handling just for this.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |  20 +++++
 sound/soc/soc-utils.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 219 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 795e6c4..750d38d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1718,4 +1718,24 @@ static inline void snd_soc_dapm_mutex_unlock(struct snd_soc_dapm_context *dapm)
 	mutex_unlock(&dapm->card->dapm_mutex);
 }
 
+int snd_soc_component_enable_pin(struct snd_soc_component *component,
+				 const char *pin);
+int snd_soc_component_enable_pin_unlocked(struct snd_soc_component *component,
+					  const char *pin);
+int snd_soc_component_disable_pin(struct snd_soc_component *component,
+				  const char *pin);
+int snd_soc_component_disable_pin_unlocked(struct snd_soc_component *component,
+					   const char *pin);
+int snd_soc_component_nc_pin(struct snd_soc_component *component,
+			     const char *pin);
+int snd_soc_component_nc_pin_unlocked(struct snd_soc_component *component,
+				      const char *pin);
+int snd_soc_component_get_pin_status(struct snd_soc_component *component,
+				     const char *pin);
+int snd_soc_component_force_enable_pin(struct snd_soc_component *component,
+				       const char *pin);
+int snd_soc_component_force_enable_pin_unlocked(
+					struct snd_soc_component *component,
+					const char *pin);
+
 #endif
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 393e8f0..644d9a9 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -58,6 +58,205 @@ int snd_soc_params_to_bclk(struct snd_pcm_hw_params *params)
 }
 EXPORT_SYMBOL_GPL(snd_soc_params_to_bclk);
 
+int snd_soc_component_enable_pin(struct snd_soc_component *component,
+				 const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_enable_pin(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_enable_pin(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_enable_pin);
+
+int snd_soc_component_enable_pin_unlocked(struct snd_soc_component *component,
+					  const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_enable_pin_unlocked(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_enable_pin_unlocked(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_enable_pin_unlocked);
+
+int snd_soc_component_disable_pin(struct snd_soc_component *component,
+				  const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_disable_pin(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_disable_pin(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_disable_pin);
+
+int snd_soc_component_disable_pin_unlocked(struct snd_soc_component *component,
+					   const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_disable_pin_unlocked(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_disable_pin_unlocked(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_disable_pin_unlocked);
+
+int snd_soc_component_nc_pin(struct snd_soc_component *component,
+			     const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_nc_pin(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_nc_pin(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_nc_pin);
+
+int snd_soc_component_nc_pin_unlocked(struct snd_soc_component *component,
+				      const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_nc_pin_unlocked(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_nc_pin_unlocked(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_nc_pin_unlocked);
+
+int snd_soc_component_get_pin_status(struct snd_soc_component *component,
+				     const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_get_pin_status(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_get_pin_status(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_get_pin_status);
+
+int snd_soc_component_force_enable_pin(struct snd_soc_component *component,
+				       const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_force_enable_pin(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_force_enable_pin(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_force_enable_pin);
+
+int snd_soc_component_force_enable_pin_unlocked(
+					struct snd_soc_component *component,
+					const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_force_enable_pin_unlocked(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_force_enable_pin_unlocked(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_force_enable_pin_unlocked);
+
 static const struct snd_pcm_hardware dummy_dma_hardware = {
 	/* Random values to keep userspace happy when checking constraints */
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
-- 
1.9.1

